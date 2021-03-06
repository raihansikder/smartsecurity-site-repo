<?php 
include("config.php");
$sql = "select * from user where user_active='1'";
$result = mysql_query($sql)or die(mysql_error());
$arr = mysql_fetch_rowsarr($result);
$rows=mysql_num_rows($result);
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<?php include_once('inc.head.php')?>
</head>
<body>
<div id="wrapper">
  <div id="container">
    <div id="top1">
      <?php include('top.php');?>
    </div>
    <h2>List of Users</h2>
    <?php include('snippets/user/usermenu.php');?>
	<?php 
	if(hasPermission('user','add',$_SESSION[current_user_id])){ ?>
    <div class='add_button_large'><a href="user_add.php?param=add"><img src="images/plus.png" />Add new User</a></div>
    <?php } ?>

    <div id="mid">
      <div class="clear"></div>
      <table id="datatable" width="100%" >
      <thead>
        <tr>
          <td >S/L</td>
          <td >Full name</td>
          <td>License Issue Date</td>
          <td>License Expiry Date</td>
          <td>First Aid Issue Date</td>
          <td>First Aid Expiry Date</td>
          <td>e-mail</td>
          <td>Primary Number</td>
          <td>Secondary Number</td>
          <td >type</td>
          <td >Action</td>
        </tr>
        </thead>
        <tbody>
        <?php for($i=0;$i<$rows;$i++){?>
         <tr id="<?php echo $arr[$i][user_id]; ?>" >
          <td><?php echo $arr[$i][user_id];?></td>
          <td><?php echo $arr[$i][user_fullname]?></td>
          <td><?php echo $arr[$i][user_license_issue_date]?></td>
          <td><?php echo $arr[$i][user_license_expiry_date]?></td>
          <td><?php echo $arr[$i][user_first_aid_issue_date]?></td>
          <td><?php echo $arr[$i][user_first_aid_expiry_date]?></td>
          <td width="100"><?php echo $arr[$i][user_email]?></td>
          <td><?php echo $arr[$i][user_phone]?></td>
          <td><?php echo $arr[$i][user_phone_secondary]?></td>
          <td><?php echo getUserTypeName($arr[$i][user_type_id]);?></td>
          <td  width="70">
          <?php 
          
		  if(hasPermission('user', 'edit', $_SESSION[current_user_id])){
			//if($arr[$i][user_name]!='superadmin'){  			  
          		echo "<a href='user_add.php?user_id=".$arr[$i][user_id]."&param=edit' class='none'>Edit</a> ";         		
			//}
          }
		  if(hasPermission('user', 'view', $_SESSION[current_user_id])){
			//if($arr[$i][user_name]!='superadmin'){  			  
          		echo "<a href='user_add.php?user_id=".$arr[$i][user_id]."&param=view'><img src='images/viewIcon.png' alt='View' width='15' height='15' /></a>";   
				     		
                                            ?> 
                                            <img id="<?php echo $arr[$i][user_id]; ?>" class="delete_user" src="images/delete-icon-md.png" alt="Delete User" title="Delete User" width="15" height="15" style="cursor:pointer;"/>
                                        <?php }
                                        ?> 

                                    </td>
                                </tr>
                            <?php } ?>        
                            </tbody>
      </table>
    </div>
  </div>
  <div id="footer">
    <?php include('footer.php');?>
  </div>
            <div id="dialog-confirm" style="display: none;" title="Confirm Your Action">
               <input name="confirm_checkbox" id="confirm_checkbox" type="checkbox" value="confirmed" class="validate[required]"/><span style="float: left; margin: 0 7px 20px 0;"></span>Please confirm the action by checking the box to the left.
            </div>
</div>
</body>
</html>
<script type="text/javascript">
    /* Identify click event on an image that has class ?delete_client? */
  
    $('img[class=delete_user]').click(function() {
        var client_id = $(this).attr("id");
        $( "#dialog-confirm" ).dialog({
            resizable: false,
            buttons: {
                "Delete": function() {
				if($('#confirm_checkbox').attr('checked')){                  
                    deleteRow(client_id);		
                    var checkboxes = document.getElementById('confirm_checkbox');
                    checkboxes.checked = false;			
                  $( this ).dialog( "close" );
					}
                },
                Cancel: function() {
                    var checkboxes = document.getElementById('confirm_checkbox');
                    checkboxes.checked = false;
                    $( this ).dialog( "close" );
                }
              
            }
        });
    });


    function deleteRow(user_id){        
        var loadUrl="snippets/user/ajax_delete_user.php";        
  
        var ajax_load="<img src='images/ajax-loader-1.gif' class='loading'  alt='loading...' />";   

        
        $(this).html(ajax_load); // ignore
        $.ajax({           
            type: "POST",
            url: loadUrl,
            data: { user_id: user_id}// ID that needs to be passed to php
        }).done(function( msg ) {
            //alert( "Data Saved: " + msg );
            $('.loading').hide();  // ignore
            if(msg=='success'){
                // Make the row read    
                $('tr[id='+user_id+']').css("background-color","red","color","white");
                // Remove the row from table
                $('tr[id='+user_id+']').fadeOut('slow');
                //$('#port_of_loading_loader').html(msg);
            }else{
                alert(msg);   
            }
        });
    }

</script>
