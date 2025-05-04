<?php
require_once '../../includes/config.php';
header('Content-Type: application/json');

try {
    // Thêm nguyên liệu mới
    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        if (empty($_POST['name']) || empty($_POST['unit']) || !isset($_POST['quantity']) || !isset($_POST['price'])) {
            throw new Exception('Vui lòng nhập đầy đủ thông tin bắt buộc');
        }
        $name = $_POST['name'];
        $unit = $_POST['unit'];
        $quantity = $_POST['quantity'];
        $price = $_POST['price'];
        $status = isset($_POST['status']) ? $_POST['status'] : 1;

        $stmt = $pdo->prepare("INSERT INTO ingredient (Name, Unit, StockQty, PricePerUnit, Status) VALUES (?, ?, ?, ?, ?)");
        $stmt->execute([$name, $unit, $quantity, $price, $status]);
        echo json_encode(['success' => true, 'message' => 'Thêm nguyên liệu thành công']);
        exit;
    }

    // Lấy danh sách nguyên liệu
    if ($_SERVER['REQUEST_METHOD'] === 'GET') {
        // Lấy 1 nguyên liệu theo id
        if (isset($_GET['id'])) {
            $id = $_GET['id'];
            $stmt = $pdo->prepare("SELECT IngrID, Name, Unit, StockQty, PricePerUnit, Status, Note FROM ingredient WHERE IngrID = ?");
            $stmt->execute([$id]);
            $ingredient = $stmt->fetch(PDO::FETCH_ASSOC);
            if ($ingredient) {
                echo json_encode(['success' => true, 'data' => $ingredient]);
            } else {
                echo json_encode(['success' => false, 'message' => 'Không tìm thấy nguyên liệu']);
            }
            exit;
        }
        
        $stmt = $pdo->query("SELECT IngrID, Name, Unit, StockQty, PricePerUnit, Status, Note, CreatedAt, UpdatedAt FROM ingredient ORDER BY IngrID ASC");
        $ingredients = $stmt->fetchAll(PDO::FETCH_ASSOC);
        echo json_encode(['success' => true, 'data' => $ingredients]);
        exit;
    }

    // Xóa nguyên liệu
    if ($_SERVER['REQUEST_METHOD'] === 'DELETE') {
        if (empty($_GET['id'])) throw new Exception('ID không được để trống');
        $id = $_GET['id'];
        $stmt = $pdo->prepare("DELETE FROM ingredient WHERE IngrID = ?");
        $stmt->execute([$id]);
        echo json_encode(['success' => true, 'message' => 'Xóa nguyên liệu thành công']);
        exit;
    }

    // Cập nhật nguyên liệu
    if ($_SERVER['REQUEST_METHOD'] === 'PUT') {
        parse_str(file_get_contents("php://input"), $put_vars);
        if (empty($put_vars['id'])) throw new Exception('ID không được để trống');
        $id = $put_vars['id'];
        $name = $put_vars['name'] ?? '';
        $unit = $put_vars['unit'] ?? '';
        $quantity = $put_vars['quantity'] ?? 0;
        $price = $put_vars['price'] ?? 0;
        $status = isset($put_vars['status']) ? $put_vars['status'] : 1;
        $note = $put_vars['note'] ?? null;

        if (empty($name) || empty($unit)) throw new Exception('Vui lòng nhập đầy đủ thông tin bắt buộc');
        $stmt = $pdo->prepare("UPDATE ingredient SET Name=?, Unit=?, StockQty=?, PricePerUnit=?, Status=?, Note=? WHERE IngrID=?");
        $stmt->execute([$name, $unit, $quantity, $price, $status, $note, $id]);
        echo json_encode(['success' => true, 'message' => 'Cập nhật nguyên liệu thành công']);
        exit;
    }

    throw new Exception('Invalid request method');
} catch (Exception $e) {
    http_response_code(400);
    echo json_encode(['success' => false, 'message' => $e->getMessage()]);
    exit;
}
?>