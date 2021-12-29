<?php
    include_once('lib/db.php');
    $db = new DB();
    switch ($_SERVER["REQUEST_METHOD"]) {
        case 'POST':
            $req = [];
            parse_str($_POST['req'], $req);
            if (!empty($req['cookie'])) {
                $cookie = explode(':', $req['cookie']);
                $selector = $cookie[0];
                $authenticator = base64_decode($cookie[1]);
                if ($db->check($selector, $authenticator)) {
                    echo 'ok';
                    break;
                }
                
                echo 'failed';
                break;
            }
            if (empty($req['login']) || empty($req['password'])) {
                echo 'failed';
                break;
            } elseif ($db->login($req['login'], $req['password'])) {
                $selector = base64_encode(random_bytes(9));
                $authenticator = random_bytes(33);

                $domain = '';
                if (!empty($_SERVER['HTTP_HOST'])) {
                    $domain = $_SERVER['HTTP_HOST'];
                } else {
                    $domain = $_SERVER['SERVER_NAME '];
                }

                $time = '';
                if (isset($req['remember'])) {
                    $time = 30;
                    $mtime = 30 * 24 * 60 * 60;
                } else {
                    $mtime = ini_get("session.gc_maxlifetime");
                }
                
                $res = $db->remember($selector, $authenticator, $mtime);
                if (!$res) {
                    echo 'failed';
                    break;
                }

                echo json_encode(['data' => $selector.':'.base64_encode($authenticator), 'time' => $time]);
            } else {
                echo 'failed';
                break;
            }

            break;
        case 'GET':
            $request = explode('?', $_SERVER['REQUEST_URI']);
            if ($request[0] == '/users') {
                $out = [];
                parse_str($_SERVER['QUERY_STRING'], $out);
                if (intval($out['page']) > 0) {
                    $res = $db->students(intval($out['page']));
                } else {
                    $res = $db->students();
                }
                echo json_encode($res);
            } elseif ($request[0] == '/count') {
                echo $db->count();
            }

            break;
        case 'DELETE':
            parse_str($_SERVER['HTTP_COOKIE'], $cookie);
            if (!empty($cookie['remember'])) {
                $cookie = explode(':', $cookie['remember']);
                $cookie = urlencode($cookie[0]);
                if ($db->remove($cookie)) {
                    echo 'ok';
                }
            }

            break;
        default:
            break;
    }
?>