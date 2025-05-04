<?php
require_once '../../includes/config.php';
header('Content-Type: application/json');

try {
    // Thêm đơn hàng mới
    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        // Lấy các trường cần thiết từ $_POST
        // (bạn có thể bổ sung validate chi tiết hơn)
        $userID = $_POST['userID'];
        $orderNumber = $_POST['orderNumber'];
        $orderTime = $_POST['orderTime'];
        $deliveryAddress = $_POST['deliveryAddress'];
        $deliveryLat = $_POST['deliveryLat'] ?? null;
        $deliveryLng = $_POST['deliveryLng'] ?? null;
        $contactPhone = $_POST['contactPhone'];
        $contactName = $_POST['contactName'];
        $deliveryFee = $_POST['deliveryFee'] ?? 0;
        $subTotal = $_POST['subTotal'];
        $discount = $_POST['discount'] ?? 0;
        $totalAmount = $_POST['totalAmount'];
        $paymentMethod = $_POST['paymentMethod'];
        $paymentStatus = $_POST['paymentStatus'] ?? 'Chưa thanh toán';
        $orderStatus = $_POST['orderStatus'] ?? 'Chờ xác nhận';
        $estimatedDeliveryTime = $_POST['estimatedDeliveryTime'] ?? null;
        $actualDeliveryTime = $_POST['actualDeliveryTime'] ?? null;
        $cancellationReason = $_POST['cancellationReason'] ?? null;
        $notes = $_POST['notes'] ?? null;

        $stmt = $pdo->prepare("INSERT INTO online_order (UserID, OrderNumber, OrderTime, DeliveryAddress, DeliveryLat, DeliveryLng, ContactPhone, ContactName, DeliveryFee, SubTotal, Discount, TotalAmount, PaymentMethod, PaymentStatus, OrderStatus, EstimatedDeliveryTime, ActualDeliveryTime, CancellationReason, Notes) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
        $stmt->execute([$userID, $orderNumber, $orderTime, $deliveryAddress, $deliveryLat, $deliveryLng, $contactPhone, $contactName, $deliveryFee, $subTotal, $discount, $totalAmount, $paymentMethod, $paymentStatus, $orderStatus, $estimatedDeliveryTime, $actualDeliveryTime, $cancellationReason, $notes]);
        echo json_encode(['success' => true, 'message' => 'Thêm đơn hàng online thành công']);
        exit;
    }

    // Lấy danh sách đơn hàng online
    if ($_SERVER['REQUEST_METHOD'] === 'GET') {
        // Lấy 1 đơn hàng theo id
        if (isset($_GET['id'])) {
            $id = $_GET['id'];
            $stmt = $pdo->prepare("SELECT * FROM online_order WHERE OrderID = ?");
            $stmt->execute([$id]);
            $order = $stmt->fetch(PDO::FETCH_ASSOC);
            if ($order) {
                echo json_encode(['success' => true, 'data' => $order]);
            } else {
                echo json_encode(['success' => false, 'message' => 'Không tìm thấy đơn hàng']);
            }
            exit;
        }
        
        $stmt = $pdo->query("SELECT * FROM online_order ORDER BY OrderID ASC");
        $orders = $stmt->fetchAll(PDO::FETCH_ASSOC);
        echo json_encode(['success' => true, 'data' => $orders]);
        exit;
    }

    // Xóa đơn hàng
    if ($_SERVER['REQUEST_METHOD'] === 'DELETE') {
        if (empty($_GET['id'])) throw new Exception('ID không được để trống');
        $id = $_GET['id'];
        $stmt = $pdo->prepare("DELETE FROM online_order WHERE OrderID = ?");
        $stmt->execute([$id]);
        echo json_encode(['success' => true, 'message' => 'Xóa đơn hàng thành công']);
        exit;
    }

    // Cập nhật đơn hàng
    if ($_SERVER['REQUEST_METHOD'] === 'PUT') {
        parse_str(file_get_contents("php://input"), $put_vars);
        if (empty($put_vars['id'])) throw new Exception('ID không được để trống');
        $id = $put_vars['id'];
        $userID = $put_vars['userID'] ?? '';
        $orderNumber = $put_vars['orderNumber'] ?? '';
        $orderTime = $put_vars['orderTime'] ?? '';
        $deliveryAddress = $put_vars['deliveryAddress'] ?? '';
        $deliveryLat = $put_vars['deliveryLat'] ?? null;
        $deliveryLng = $put_vars['deliveryLng'] ?? null;
        $contactPhone = $put_vars['contactPhone'] ?? '';
        $contactName = $put_vars['contactName'] ?? '';
        $deliveryFee = $put_vars['deliveryFee'] ?? 0;
        $subTotal = $put_vars['subTotal'] ?? 0;
        $discount = $put_vars['discount'] ?? 0;
        $totalAmount = $put_vars['totalAmount'] ?? 0;
        $paymentMethod = $put_vars['paymentMethod'] ?? '';
        $paymentStatus = $put_vars['paymentStatus'] ?? '';
        $orderStatus = $put_vars['orderStatus'] ?? '';
        $estimatedDeliveryTime = $put_vars['estimatedDeliveryTime'] ?? null;
        $actualDeliveryTime = $put_vars['actualDeliveryTime'] ?? null;
        $cancellationReason = $put_vars['cancellationReason'] ?? null;
        $notes = $put_vars['notes'] ?? null;

        if (empty($userID) || empty($orderNumber) || empty($orderTime) || empty($deliveryAddress) || empty($contactPhone) || empty($contactName)) {
            throw new Exception('Vui lòng nhập đầy đủ thông tin bắt buộc');
        }

        $stmt = $pdo->prepare("UPDATE online_order SET UserID=?, OrderNumber=?, OrderTime=?, DeliveryAddress=?, DeliveryLat=?, DeliveryLng=?, ContactPhone=?, ContactName=?, DeliveryFee=?, SubTotal=?, Discount=?, TotalAmount=?, PaymentMethod=?, PaymentStatus=?, OrderStatus=?, EstimatedDeliveryTime=?, ActualDeliveryTime=?, CancellationReason=?, Notes=? WHERE OrderID=?");
        $stmt->execute([$userID, $orderNumber, $orderTime, $deliveryAddress, $deliveryLat, $deliveryLng, $contactPhone, $contactName, $deliveryFee, $subTotal, $discount, $totalAmount, $paymentMethod, $paymentStatus, $orderStatus, $estimatedDeliveryTime, $actualDeliveryTime, $cancellationReason, $notes, $id]);
        echo json_encode(['success' => true, 'message' => 'Cập nhật đơn hàng thành công']);
        exit;
    }

    throw new Exception('Invalid request method');
} catch (Exception $e) {
    http_response_code(400);
    echo json_encode(['success' => false, 'message' => $e->getMessage()]);
    exit;
}
?>
