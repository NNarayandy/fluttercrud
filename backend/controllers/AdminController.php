<?php
include_once '../../config/database.php';
include_once '../../models/Admin.php';

class AdminController {
    private $conn;
    private $admin;

    public function __construct() {
        global $conn;
        $this->conn = $conn;
        $this->admin = new Admin($this->conn);
    }

    public function login($username, $password) {
        return $this->admin->authenticate($username, $password);
    }
}
?>