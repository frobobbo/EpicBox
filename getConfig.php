<?php
date_default_timezone_set('America/Detroit');

function checkin($mac){
	$mysqli = new mysqli("localhost", "epicbox", "KROpR4RQFYDCJ9Q0", "tblBoxes");
	$sql = "UPDATE tblBoxes SET lastCheckin='". date("m/d/Y h:i:sa",time()) ."' WHERE boxMac=".$mac;
	$mysqli->query($sql);
}

$mac = $_POST["mac"];

checkin($mac);

$mysqli = new mysqli("localhost", "epicbox", "KROpR4RQFYDCJ9Q0", "tblBoxes");

$sql = "SELECT boxCustomer, boxEndpoint, boxRegion, boxAccessKey, boxSecretKey, boxBucket FROM tblBoxes WHERE boxMac='".$mac."'";
$result = $mysqli->query($sql);

$boxInfo = mysqli_fetch_row($result);
$boxEndpoint = $boxInfo["boxEndpoint"]; 
$boxRegion = $boxInfo["boxRegion"]; 
$boxAccessKey = $boxInfo["boxAccessKey"]; 
$boxSecretKey = $boxInfo["boxSecretKey"]; 
$boxBucket = $boxInfo["boxBucket"]; 
$boxCustomer = $boxInfo["boxCustomer"]; 


echo "[DataStore]\r\n";
echo "endpoint = " + $boxEndpoint;
echo "region = " + $boxRegion;
echo "accessKey = " + $boxAccessKey;
echo "secretKey = " + $boxSecretKey;
echo "bucketName = " + $boxBucket;
echo "customerFolder" + $boxCustomer;

?>