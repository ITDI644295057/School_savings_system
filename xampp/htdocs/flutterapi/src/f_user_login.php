<?php
header("Access-Control-Allow-Origin: *");
header('Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept');  
header("Content-type:application/json",true);

$conn = @mysqli_connect('localhost', 'root', '', 'flutterdb');
$conn -> set_charset("utf8");

$u = $_POST["username"];
$pa = $_POST["password"];
$sql = "SELECT * FROM login WHERE username = '$u' AND password = '$pa'";

$result = $conn ->query($sql);
$num = mysqli_num_rows($result);

$arr = array();
if ($num > 0) {
   while($row = mysqli_fetch_assoc($result)){
        $message = (object)array('username' => $row["username"], 'password' => $row["password"]); 
        echo json_encode($message);        
   }
} else {	
        $message = (object)array('username' => 'failed', 'password' => 'failed'); 
        echo json_encode($message);        
}
?>
