<?php
require_once '../../includes/config.php';

// Enable error reporting for debugging
error_reporting(E_ALL);
ini_set('display_errors', 1);

header('Content-Type: application/json');

try {
    
    // Xử lý thêm thức uống mới
    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        if (empty($_POST['name']) || empty($_POST['price'])) {
            throw new Exception('Tên và giá không được để trống');
        }

        $name = $_POST['name'];
        $price = $_POST['price'];
        $category = $_POST['category'] ?? 'Cà phê';
        $size = $_POST['size'] ?? 'M';
        $status = isset($_POST['status']) ? (int)$_POST['status'] : 1; // Mặc định là còn bán (1)
        
        $stmt = $pdo->prepare("INSERT INTO drink (Name, Price, Category, Size, Status) VALUES (?, ?, ?, ?, ?)");
        $stmt->execute([$name, $price, $category, $size, $status]);
        
        echo json_encode(['success' => true, 'message' => 'Thêm thức uống thành công']);
        exit;
    }

    // Lấy danh sách thức uống
    if ($_SERVER['REQUEST_METHOD'] === 'GET') {
        $stmt = $pdo->query("SELECT DrinkID, Name, Category, SubCategory, Size, Price, Status FROM drink ORDER BY DrinkID ASC");
        $drinks = $stmt->fetchAll(PDO::FETCH_ASSOC);
        echo json_encode(['success' => true, 'data' => $drinks]);
        exit;
    }

    // Lấy 1 thức uống theo id
    if ($_SERVER['REQUEST_METHOD'] === 'GET' && isset($_GET['id'])) {
        $id = $_GET['id'];
        $stmt = $pdo->prepare("SELECT DrinkID, Name, Category, Size, Price, Status FROM drink WHERE DrinkID = ?");
        $stmt->execute([$id]);
        $drink = $stmt->fetch(PDO::FETCH_ASSOC);
        if ($drink) {
            echo json_encode(['success' => true, 'data' => $drink]);
        } else {
            echo json_encode(['success' => false, 'message' => 'Không tìm thấy thức uống']);
        }
        exit;
    }

    // Xóa thức uống
    if ($_SERVER['REQUEST_METHOD'] === 'DELETE') {
        if (empty($_GET['id'])) {
            throw new Exception('ID không được để trống');
        }
        
        $id = $_GET['id'];
        $stmt = $pdo->prepare("DELETE FROM drink WHERE DrinkID = ?");
        $stmt->execute([$id]);
        
        echo json_encode(['success' => true, 'message' => 'Xóa thức uống thành công']);
        exit;
    }

    // Cập nhật thức uống
    if ($_SERVER['REQUEST_METHOD'] === 'PUT') {
        parse_str(file_get_contents("php://input"), $put_vars);
        if (empty($put_vars['id'])) {
            throw new Exception('ID không được để trống');
        }
        $id = $put_vars['id'];
        $name = $put_vars['name'] ?? '';
        $price = $put_vars['price'] ?? '';
        $category = $put_vars['category'] ?? '';
        $size = $put_vars['size'] ?? '';
        $status = isset($put_vars['status']) ? (int)$put_vars['status'] : 1;
        if (empty($name) || empty($price)) {
            throw new Exception('Tên và giá không được để trống');
        }
        $stmt = $pdo->prepare("UPDATE drink SET Name = ?, Price = ?, Category = ?, Size = ?, Status = ? WHERE DrinkID = ?");
        $stmt->execute([$name, $price, $category, $size, $status, $id]);
        echo json_encode(['success' => true, 'message' => 'Cập nhật thức uống thành công']);
        exit;
    }

    // Nếu không match với method nào
    throw new Exception('Invalid request method');

} catch (Exception $e) {
    http_response_code(400);
    echo json_encode(['success' => false, 'message' => $e->getMessage()]);
    exit;
}
?> 