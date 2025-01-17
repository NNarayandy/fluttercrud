<?php
class Admin {
    private $conn;

    public function __construct($conn) {
        $this->conn = $conn;
    }

    public function authenticate($username, $password) {
        $query = "SELECT * FROM admin WHERE username = ? AND password = ?";
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("ss", $username, $password);
        $stmt->execute();
        $result = $stmt->get_result();
        return $result->num_rows === 1;
    }
}
?>