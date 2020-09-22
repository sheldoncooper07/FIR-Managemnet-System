<?php
session_start();
include('dbengine.php');

$database = Database_Factory::create(1);
$database->connect($_SESSION['url'],$_SESSION['username'],$_SESSION['password'],$_SESSION['database']);
$results_string = '';

if(isset($_SESSION['query'])) {
    $_SESSION['results'] = $database->run_query($_SESSION['query']);
    if(is_string($_SESSION['results'])){
        if(!empty($_SESSION['results'])) {
            $results_string .= "<h2 style='color:red;'> Please give correct input values for insert/delete query. </h2>";
        }
    }
    unset($_SESSION['query']);
}
else if(isset($_POST['logout'])) {
    session_destroy();
    header('Location:index.php');
} 
else if(isset($_POST['insert'])) {
    $table_name = $_SESSION['name'];
    $res = $database->run_query('select * from '.$table_name);

    $query = "INSERT INTO ".$table_name. " Values(";

    $fields1 = $res->fetch_fields();
    $data_arr = array();
    foreach($fields1 as $fa){
        $val = $_POST[$fa->name];
        array_push($data_arr, $val);
    }

    $arrlength = count($data_arr);
    for($x = 0; $x < $arrlength-1; $x++) {
        $query .= $data_arr[$x].",";
    }

    $query .= $data_arr[$arrlength-1].")";
    $_SESSION['query'] = $query;
    redirect('table.php');
}
else if(isset($_POST['delete'])) {
    $table_name = $_SESSION['name'];
    $res = $database->run_query('select * from '.$table_name);

    $query = "DELETE FROM ".$table_name. " WHERE ";

    $fields1 = $res->fetch_fields();
    $data_arr = array();
    foreach($fields1 as $fa){
        $val = $_POST[$fa->name];
        if(! empty($val)) {
            array_push($data_arr, $fa->name, $val);
        }
    }

    $arrlength = count($data_arr);
    for($x = 0; $x < $arrlength-2; $x+=2) {
        $query .= $data_arr[$x]."=".$data_arr[$x+1]. " AND ";
    }

    $query .= $data_arr[$arrlength-2]."=".$data_arr[$arrlength-1];
    echo $query;
    $_SESSION['query'] = $query;
    redirect('table.php');
}

function redirect($url)
{
    if (!headers_sent())
    {    
        header('Location: '.$url);
        exit;
        }
    else
        {  
        echo '<script type="text/javascript">';
        echo 'window.location.href="'.$url.'";';
        echo '</script>';
        echo '<noscript>';
        echo '<meta http-equiv="refresh" content="0;url='.$url.'" />';
        echo '</noscript>'; exit;
    }
}
?>
<?php
$table_data = '';
    $que = 'SELECT * FROM '.$_SESSION['name'];
    $_SESSION['results'] = $database->run_query($que);
    if(is_string($_SESSION['results'])){
        $table_data = "<h2 style='color:red;'>".$_SESSION['results']."</h2>";
    }else{
        $results = $_SESSION['results'];
        $field_count = $results->field_count;
        $fields = $results->fetch_fields();

        $table_data .= '<table border=1 class="display"><tr style="color:green;">';
        foreach($fields as $field){
            $table_data .= '<td>'.$field->name.'</td>';
        }
        $table_data .= '</tr>';
        while($row = $results->fetch_row()){
            $table_data .= '<tr>';
            for($i = 0; $i < $field_count; $i++){
                $table_data .= '<td>'.$row[$i]."</td>";
            }
            $table_data .= '</tr>';
        }
        $table_data .= '</table>';
    }
?>

<!DOCTYPE>
<html>
<head>
    <link href="style.css" rel="stylesheet">
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
<script>
function goBack()
  {
  window.history.back()
  }
</script>
</head>
<body>
    <header style='text-align:center;'>
        <h1>FIR Management System</h1>
    </header>
<div id='middle' style='width: auto;height: 1000px; '>
    <div id='center' style='width: 1000px;margin-left: auto;margin-right: auto;'>
        <hr />
        <div id='l-middle' style='float: right; text-align:center;'>
            <b>Welcome back</b><br />
            <?php echo $_SESSION['username']; ?><br />
            <form action="table.php" method="post">
                <input type='submit' value='Logout' id='logout' name='logout'/>
            </form>
        </div><!--END OF L-MIDDLE-->
        <div id='inner_center' style='width:500px;margin-left: auto; margin-right:auto;'>
            <div id='sql_results'>
                <h2>Insert</h2>
                    <form action="table.php" method="post">
                        <table>
                        <?php
                            $table_name = $_SESSION['name'];
                            $res = $database->run_query('select * from '.$table_name);

                            $fields1 = $res->fetch_fields();
                            foreach($fields1 as $fa){
                                echo "<tr><td><label for='".$fa->name."'>";
                                echo $fa->name.": </label></td>";
                                echo "<td><input type='textbox' id='";
                                echo $fa->name."' name='".$fa->name."'style='width: 150px;'/></td></tr>";
                                // echo $fa->name;
                            }
                        ?>
                        </table>
                        <p>*Strings should be written with quotes, and for null values write NULL.</p>
                        <input type='submit' value='insert' id='insert' name='insert'/>
                    </form>
            </div><!--END OF SQL RESULTS-->
        </div><!--END OF INNER CENTER-->


        <div id='inner_center' style='width:500px;margin-left: auto; margin-right:auto;'>
            <div id='sql_results'>
                <h2>Delete</h2>
                    <form action="table.php" method="post">
                        <table>
                        <?php
                            $table_name = $_SESSION['name'];
                            $res = $database->run_query('select * from '.$table_name);

                            $fields1 = $res->fetch_fields();
                            foreach($fields1 as $fa){
                                echo "<tr><td><label for='".$fa->name."'>";
                                echo $fa->name.": </label></td>";
                                echo "<td><input type='textbox' id='";
                                echo $fa->name."' name='".$fa->name."'style='width: 150px;'/></td></tr>";
                                // echo $fa->name;
                            }
                        ?>
                        </table>
                        <p>*Strings should be written with quotes, and for null values write NULL.</p>
                        <input type='submit' value='delete' id='delete' name='delete'/>
                    </form>
                <?php echo $table_data?>
                <?php echo $results_string ?>
                <a href='sql.php'> Back to SQL </a>
            </div><!--END OF SQL RESULTS-->
        </div><!--END OF INNER CENTER-->

        <div id='r-middle' style='float: right;'>
        </div> <!--END OF R-MIDDLE-->
        <div id='footer' style='clear:both;'>
            <hr />
        </div><!--END OF FOOTER-->
    </div> <!--END OF CENTER-->
</div> <!--END OF MIDDLE-->
</body>
</html>
