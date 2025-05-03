<?php
require_once '../../includes/config.php';
header('Content-Type: application/json');

try {
    // Thêm hóa đơn mới
    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        if (empty($_POST['customerID']) || empty($_POST['employeeID']) || empty($_POST['dateCreated']) || empty($_POST['totalAmount'])) {
            throw new Exception('Vui lòng nhập đầy đủ thông tin bắt buộc');
        }
        $customerID = $_POST['customerID'];
        $empID = $_POST['employeeID'];
        $dateTime = $_POST['dateCreated'];
        $totalAmount = $_POST['totalAmount'];
        $paymentStatus = $_POST['status'] ?? 'Chưa thanh toán';
        $note = $_POST['note'] ?? null;

        $stmt = $pdo->prepare("INSERT INTO invoice (CustomerID, EmpID, DateTime, TotalAmount, PaymentStatus, Notes) VALUES (?, ?, ?, ?, ?, ?)");
        $stmt->execute([$customerID, $empID, $dateTime, $totalAmount, $paymentStatus, $note]);
        echo json_encode(['success' => true, 'message' => 'Tạo hóa đơn thành công']);
        exit;
    }

    // Lấy danh sách hóa đơn
    if ($_SERVER['REQUEST_METHOD'] === 'GET') {
        $stmt = $pdo->query("SELECT InvoiceID, CustomerID, EmpID, DateTime, TotalAmount, PaymentStatus, Notes FROM invoice ORDER BY InvoiceID ASC");
        $invoices = $stmt->fetchAll(PDO::FETCH_ASSOC);
        echo json_encode(['success' => true, 'data' => $invoices]);
        exit;
    }

    // Xóa hóa đơn
    if ($_SERVER['REQUEST_METHOD'] === 'DELETE') {
        if (empty($_GET['id'])) throw new Exception('ID không được để trống');
        $id = $_GET['id'];
        $stmt = $pdo->prepare("DELETE FROM invoice WHERE InvoiceID = ?");
        $stmt->execute([$id]);
        echo json_encode(['success' => true, 'message' => 'Xóa hóa đơn thành công']);
        exit;
    }

    // Cập nhật hóa đơn
    if ($_SERVER['REQUEST_METHOD'] === 'PUT') {
        parse_str(file_get_contents("php://input"), $put_vars);
        if (empty($put_vars['id'])) throw new Exception('ID không được để trống');
        $id = $put_vars['id'];
        $customerID = $put_vars['customerID'] ?? '';
        $empID = $put_vars['employeeID'] ?? '';
        $dateTime = $put_vars['dateCreated'] ?? '';
        $totalAmount = $put_vars['totalAmount'] ?? 0;
        $paymentStatus = $put_vars['status'] ?? '';
        $note = $put_vars['note'] ?? '';

        if (empty($customerID) || empty($empID) || empty($dateTime) || empty($totalAmount)) throw new Exception('Vui lòng nhập đầy đủ thông tin bắt buộc');
        $stmt = $pdo->prepare("UPDATE invoice SET CustomerID=?, EmpID=?, DateTime=?, TotalAmount=?, PaymentStatus=?, Notes=? WHERE InvoiceID=?");
        $stmt->execute([$customerID, $empID, $dateTime, $totalAmount, $paymentStatus, $note, $id]);
        echo json_encode(['success' => true, 'message' => 'Cập nhật hóa đơn thành công']);
        exit;
    }

    throw new Exception('Invalid request method');
} catch (Exception $e) {
    http_response_code(400);
    echo json_encode(['success' => false, 'message' => $e->getMessage()]);
    exit;
}
?>