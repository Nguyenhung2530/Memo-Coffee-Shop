<?php
require_once '../../includes/config.php';

header('Content-Type: application/json');

try {
    // Xử lý thêm nhân viên mới
    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        if (empty($_POST['fullname']) || empty($_POST['phone']) || empty($_POST['position']) || empty($_POST['salary'])) {
            throw new Exception('Vui lòng điền đầy đủ thông tin bắt buộc');
        }

        $fullname = $_POST['fullname'];
        $gender = $_POST['gender'] ?? 'Khác';
        $phone = $_POST['phone'];
        $email = $_POST['email'] ?? null;
        $position = $_POST['position'];
        $salary = $_POST['salary'];
        $startDate = $_POST['start_date'] ?? date('Y-m-d');
        $status = $_POST['status'] ?? 'Đang làm';
        
        $stmt = $pdo->prepare("INSERT INTO employee (FullName, Gender, Phone, Email, Position, Salary, StartDate, Status) 
                              VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
        $stmt->execute([$fullname, $gender, $phone, $email, $position, $salary, $startDate, $status]);
        
        echo json_encode(['success' => true, 'message' => 'Thêm nhân viên thành công']);
        exit;
    }

    // Lấy danh sách nhân viên hoặc 1 nhân viên theo id
    if ($_SERVER['REQUEST_METHOD'] === 'GET') {
        if (isset($_GET['id'])) {
            $id = $_GET['id'];
            $stmt = $pdo->prepare("SELECT EmpID, FullName, Gender, Phone, Email, Position, Salary, StartDate, Status FROM employee WHERE EmpID = ?");
            $stmt->execute([$id]);
            $emp = $stmt->fetch(PDO::FETCH_ASSOC);
            if ($emp) {
                echo json_encode(['success' => true, 'data' => $emp]);
            } else {
                echo json_encode(['success' => false, 'message' => 'Không tìm thấy nhân viên']);
            }
            exit;
        }
        $stmt = $pdo->query("SELECT EmpID, FullName, Gender, Phone, Email, Position, Salary, StartDate, Status FROM employee ORDER BY EmpID ASC");
        $employees = $stmt->fetchAll(PDO::FETCH_ASSOC);
        echo json_encode(['success' => true, 'data' => $employees]);
        exit;
    }

    // Xóa nhân viên
    if ($_SERVER['REQUEST_METHOD'] === 'DELETE') {
        if (empty($_GET['id'])) {
            throw new Exception('ID không được để trống');
        }
        
        $id = $_GET['id'];
        $stmt = $pdo->prepare("DELETE FROM employee WHERE EmpID = ?");
        $stmt->execute([$id]);
        
        echo json_encode(['success' => true, 'message' => 'Xóa nhân viên thành công']);
        exit;
    }

    // Cập nhật nhân viên
    if ($_SERVER['REQUEST_METHOD'] === 'PUT') {
        parse_str(file_get_contents("php://input"), $put_vars);
        if (empty($put_vars['id'])) {
            throw new Exception('ID không được để trống');
        }
        
        $id = $put_vars['id'];
        $fullname = $put_vars['fullname'] ?? '';
        $gender = $put_vars['gender'] ?? '';
        $phone = $put_vars['phone'] ?? '';
        $email = $put_vars['email'] ?? '';
        $position = $put_vars['position'] ?? '';
        $salary = $put_vars['salary'] ?? '';
        $status = $put_vars['status'] ?? '';
        
        if (empty($fullname) || empty($phone) || empty($position) || empty($salary)) {
            throw new Exception('Vui lòng điền đầy đủ thông tin bắt buộc');
        }
        
        $stmt = $pdo->prepare("UPDATE employee SET 
            FullName = ?, Gender = ?, Phone = ?, Email = ?, Position = ?, Salary = ?, Status = ? 
            WHERE EmpID = ?");
        $stmt->execute([$fullname, $gender, $phone, $email, $position, $salary, $status, $id]);
        
        echo json_encode(['success' => true, 'message' => 'Cập nhật nhân viên thành công']);
        exit;
    }

    throw new Exception('Invalid request method');

} catch (Exception $e) {
    http_response_code(400);
    echo json_encode(['success' => false, 'message' => $e->getMessage()]);
    exit;
}
?> 