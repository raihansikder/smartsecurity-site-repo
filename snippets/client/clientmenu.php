<div id='secondary_menu'>
<?php 
echo "<a href='client_view.php?client_id=$client_id'";
if(getFileName()=='client_view.php'){echo " class='selected' ";}
echo ">Basic info</a> |";
		
echo "<a href='costsheet_list.php?client_id=$client_id'";
if(getFileName()=='costsheet_list.php'){echo " class='selected' ";}
echo ">Costsheet</a> |";

echo "<a href='purchaseorder_list.php?client_id=$client_id'";
if(getFileName()=='purchaseorder_list.php'){echo " class='selected' ";}
echo ">Purchase orders</a> | ";

echo "<a href='proforma_invoice_list.php?client_id=$client_id'";
if(getFileName()=='proforma_invoice_list.php'){echo " class='selected' ";}
echo ">Proforma Invoice</a> ";

?>
</div>


