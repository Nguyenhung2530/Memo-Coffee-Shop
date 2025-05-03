<?php
session_start();

header('Content-Type: application/json');

if (!isset($_SESSION['logged_in']) || $_SESSION['logged_in'] !== true) {
    http_response_code(401);
    echo json_encode([
        'success' => false,
        'message' => 'Unauthorized access',
        'redirect' => 'index.html'
    ]);
    exit;
}

// Return user info if session is valid
echo json_encode([
    'success' => true,
    'user' => [
        'username' => $_SESSION['username'],
        'role' => $_SESSION['role']
    ]
]);
?> 