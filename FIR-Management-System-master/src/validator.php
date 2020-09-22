<?php
include('dbengine.php');
session_start();
$username = $_POST['username'];
$password = $_POST['password'];

echo $username."\n<br />";
echo $password."<br />";
//need to make sure they are correct if not redirect back to login.
$URL = 'localhost';
$DATABASE = 'firdata';

$_SESSION['username'] = $username;
$_SESSION['url'] = $URL;
$_SESSION['password'] = $password;
$_SESSION['database'] = $DATABASE;//Database_Factory::create(1);
//$_SESSION['errors'] = $_SESSION['database']->connect($URL,$username,$password,$DATABASE);
//echo $_SESSION['database']->thing();
header('Location: sql.php');
//echo $_SESSION['database']->run_query('select * from shipments')->fetch_row()[0][0];
//header('Location: sql.php');
?>
