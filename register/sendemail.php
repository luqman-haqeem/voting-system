<?php session_start();
require '../connection.php';

// get data from session
$useremail =$_SESSION['email'];
$matric_no= $_SESSION['matric_no'];
// create pin 
$pin=random_int(10000, 99999);

// message in email
$messagesubject= "Kuis e-voting system One time Password ";
$headers .= "Content-Type: text/html; charset=ISO-8859-1\r\n";
$message ="Please use this <b>One time Password</b> to login";
$message .="<br>This is your One time Password: "."<b>".$pin."</b>";

// save pin to DB 
$saveOTPtoDB=mysqli_query($db,"UPDATE login SET OTP = $pin,status = 'registed' WHERE username= '$matric_no' ");
	if ($saveOTPtoDB==false) {
        echo "Failed to register student <br>";
        echo "SQL error :".mysqli_error($db);
    }
    else{
    	// send email 
		// check whether email has been send and return to login page with message
		if (mail($useremail, $messagesubject, $message,$headers)) {
		  	header('Location: ../index.php?success=checkemail');
		  	exit();
		}
		else
			header('Location: ../index.php?error=failedtosendemail');
		  	exit();
    }

 ?>