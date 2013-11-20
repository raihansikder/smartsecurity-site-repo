<?php
/*
*	This is a temporary script to test new functions. This funcitons will be migrated to inc.funtions.appspecific.php once approved
*/

/*
* Author : Raihan Sikder
* email: raihan@activationltd.com
*/

function sendSecurityLicenceExpiryAlert($expiresInDays){
	global $scriptpath;
	$Body="";
	
	$q="select * from user where user_type_id= 3 AND user_license_expiry_date <= CURDATE()+'$expiresInDays'";
	$r=mysql_query($q)or die(mysql_error());
	$rows = mysql_num_rows($r);
		if ($rows > 0) {
		$arr = mysql_fetch_rowsarr($r);
		}
	$Body.="Dear Admin<br/>Following guard's licence is about to expire soon";
	$Body.="<table border='1' style='font-family:Verdana, Geneva, sans-serif; font-size:11px'>
			<tr style='font-weight:bold'>
			  <td>Guard name</td>
			  <td>Phone</td>
			  <td>E-mail</td>
			  <td>Expiry date</td>
			</tr>
		  ";
	for ($i = 0; $i < $rows; $i++) {
		$Body.= "<tr>";
		$Body.= "<td>".$arr[$i][user_fullname]."</td>";
		$Body.= "<td>".$arr[$i][user_phone]."</td>";
		$Body.= "<td>".$arr[$i][user_email]."</td>";
		$Body.= "<td>".date('d-M-Y', strtotime($arr[$i][user_license_expiry_date]))."</td>";
		$Body.= "</tr>";
		}
	$Body.="</table>";
	
	echo $Body;
	
	global $mail;
	//$mail->AddAddress('raihan.act@gmail.com','Raihan');
	//$mail->AddAddress('tesops@gmail.com','Tes Operations');
	$mail->AddAddress('shuvoworld@gmail.com','Enamul Haque');
	$Subject = "[Auto-email] SmartSecurity Guard's Licence Expiry Reminder";
	$mail->Subject = $Subject;
	$mail->Body = $Body;
	
	
	if(!$mail->Send()){
		echo "Mailer Error: " . $mail->ErrorInfo;
	}else{
		echo "Mail Sent!";
	}
}


?>
