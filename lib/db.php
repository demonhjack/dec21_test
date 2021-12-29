<?php
    include_once('config.php');
    class DB {

        private $con;
        public $page;

        function __construct() {
            $this->con = new mysqli(HOST, USER, PASS, DB);
            date_default_timezone_set('Europe/Moscow');
        }

        function __destruct() {
            $this->con->close();
        }
        
        function students($page = null) {
            $offset = 0;
            if (is_int($page)) {
                $offset = ($page - 1) * 5;
            }
            $res = $this->con->query('SELECT * FROM students LIMIT 5 OFFSET '.$offset);
            $out = [];
            while($row = $res->fetch_row()) {
                $out[] = [
                    'login' => $row[1],
                    'name' => $row[2],
                    'group' => $row[3]
                ];
            }

            return $out;
        }

        function count() {
            $res = $this->con->query('SELECT COUNT(id) FROM students');
            $out = [];
            while($row = $res->fetch_row()) {
                $out = $row[0];
            }
            
            return $out;
        }
        
        function login($user = null, $pass = null) {
            if (empty($user) || empty($pass)) {
                return false;
            }

            $res = $this->con->query('SELECT COUNT(id) FROM api_users WHERE username = "'.$user.'" AND password = MD5("'.$pass. '")');
            $out = [];
            while($row = $res->fetch_row()) {
                $out = $row[0];
            }
            
            if ($out > 0) {
                return true;
            } else {
                return false;
            }
        }
        
        function remember($selector = null, $authenticator = null, $mtime = null) {
            if (!empty($selector) && !empty($authenticator) && !empty($mtime)) {
                $res = $this->con->query("INSERT INTO auth_tokens (selector, token, userid, expires) VALUES ('".$selector."', '".hash("sha256", $authenticator)."', 1, '".date('Y-m-d\TH:i:s', strtotime("+".$mtime." seconds"))."')");
                if ($res == 1) {
                    return true;
                } else {
                    return false;
                }
            } else {
                return false;
            }
        }

        function check($selector = null, $authenticator = null) {
            if (!empty($selector) && !empty($authenticator)) {
                $res = $this->con->query('SELECT token FROM auth_tokens WHERE selector = "'.$selector.'" AND expires > NOW() ORDER BY id DESC LIMIT 1');
                $row = $res->fetch_row();

                if (!$row) {
                    return false;
                } else {
                    if ($row[0] == hash("sha256", $authenticator)) {
                        return true;
                    } else {
                        return false;
                    }
                }
            } else {
                return false;
            }
        }

        function remove($selector = null) {
            if (!empty($selector)) {
                return $this->con->query('DELETE FROM auth_tokens WHERE selector = "'.$selector.'"');
            } else {
                return false;
            }
        }
    }
?>