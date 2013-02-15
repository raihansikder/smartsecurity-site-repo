<?php
include("config.php");
$sql = "select * from security_site where ss_active='1' ";
$result = mysql_query($sql) or die(mysql_error());
$arr = mysql_fetch_rowsarr($result);
$rows = mysql_num_rows($result);
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
    <head>
        <?php include_once('inc.head.php') ?>
    </head>
    <body>
        <div id="wrapper">
            <div id="container">
                <div id="top1">
                    <?php include('top.php'); ?>
                </div>
                <h2>List of Sites</h2>
                <?php if (hasPermission('client', 'add', $_SESSION[current_user_id])) { ?>
                    <div class='add_button_large'><a href="security_site_add.php?param=add"><img src="images/plus.png" />Add new Site</a></div>
                <?php } ?>

                <div id="mid">
                    <div class="clear"></div>
                    <table id="datatable" width="100%" >
                        <thead>
                            <tr>
                                <td width="24" >ID</td>
                                <td width="176" >Site name</td>
                                <td width="221" >Site Address</td>
                                <td width="75" >Action</td>
                            </tr>
                        </thead>
                        <tbody>
                            <?php for ($i = 0; $i < $rows; $i++) { ?>
                                <tr id="<?php echo $arr[$i][ss_id]; ?>"><!-- NASIR KHAN | 2012-08-05 | added the row id -->
                                    <td><?php echo $arr[$i][ss_id]; ?></td>
                                    <td><?php echo $arr[$i][ss_name]; ?></td>
                                    <td><?php echo $arr[$i][ss_address]; ?></td>
                                    <td>
                                        <?php
                                        if (hasPermission('security_assignment', 'add', $_SESSION[current_user_id])) {
                                            echo "<a href='security_site_add.php?param=edit&ss_id=" . $arr[$i][ss_id] . "' class='none'>Edit</a> ";
                                        }
                                        if (hasPermission('security_assignment', 'add', $_SESSION[current_user_id])) {
                                            echo "<a href='security_site_add.php?param=view&ss_id=" . $arr[$i][ss_id] . "'><img src='images/viewIcon.png' alt='View' width='15' height='15' /></a> ";
                                            ?>
                                            <img id="<?php echo $arr[$i][ss_id]; ?>" class="delete_security_site" src="images/delete-icon-md.png" alt="Delete" title="Delete" width="15" height="15" style="cursor:pointer;"/>  <!-- NASIR KHAN | 2012-08-05 | added the delete button-->
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
                <?php include('footer.php'); ?>
            </div>
        </div>
    </body>
</html>
<!--/*
 * Author               : Nasir Khan
 * email                : nasir.khan@activationltd.com
 * updated on           : 05-08-2012
 * codeblock type       : function/procedure
 * Name                 : ajax call to delete a Security Site
 * parameter(s)         : N/A
 * Output               : remove the selected row
 * Developers Note      : 
 */-->
<script type="text/javascript">
    /* Identify click event on an image that has class ‘delete_assignment’ */
    $('img[class=delete_security_site]').click(function(){
        
        /* Define the php file with DB Query execution code. (for AJAX)*/   
        
        var loadUrl="snippets/security_site/ajax_delete_security_site.php";
        
        /* Define gif image to show temporarily when the AJAX executes*/    
        var ajax_load="<img src='images/ajax-loader-1.gif' class='loading'  alt='loading...' />";   
        /* Get teh id from the IMG that was just clicked $(this) means the this image that was just clicked*/    
        var ss_id = $(this).attr("id");
        //alert(sa_uid);
        
        $(this).html(ajax_load); // ignore
        $.ajax({           
            type: "POST",
            url: loadUrl,
            data: { ss_id: ss_id}// ID that needs to be passed to php
        }).done(function( msg ) {
            //alert( "Data Saved: " + msg );
            $('.loading').hide();  // ignore
            if(msg=='success'){
                // Make the row read    
                $('tr[id='+ss_id+']').css("background-color","red","color","white");
                // Remove the row from table
                $('tr[id='+ss_id+']').fadeOut('slow');
                //$('#port_of_loading_loader').html(msg);
            }else{
                alert(msg);   
            }
        });
        
    })
</script>

<!--END | ajax call to delete a Security Site-->