<?php
session_start();
include('dbengine.php');

$database = Database_Factory::create(1);
$database->connect($_SESSION['url'],$_SESSION['username'],$_SESSION['password'],$_SESSION['database']);
$results_string;

if(isset($_SESSION['query'])){
    $_SESSION['results'] = $database->run_query($_SESSION['query']);
    if(is_string($_SESSION['results'])){
        $results_string .= "<h2 style='color:red;'>".$_SESSION['results']."</h2>";
    }else{
        $results = $_SESSION['results'];
        $field_count = $results->field_count;
        $fields = $results->fetch_fields();

        $results_string .= '<table border=1 class="display"><tr style="color:green;">';
        foreach($fields as $field){
            $results_string .= '<td>'.$field->name.'</td>';
        }
        $results_string .= '</tr>';
        while($row = $results->fetch_row()){
            $results_string .= '<tr>';
            for($i = 0; $i < $field_count; $i++){
                $results_string .= '<td>'.$row[$i]."</td>";
            }
            $results_string .= '</tr>';
        }
        $results_string .= '</table>';
    }
    unset($_SESSION['query']);
}
else if(isset($_POST['logout'])){
    session_destroy();
    header('Location:index.php');
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
        <div id='l-middle' style='float: left; text-align:center;'>
            <b>Welcome back</b><br />
            <?php echo $_SESSION['username']; ?><br />
            <form action="results.php" method="post">
                <input type='submit' value='Logout' id='logout' name='logout'/>
            </form>
        </div><!--END OF L-MIDDLE-->
        <div id='inner_center' style='width:500px;margin-left: auto; margin-right:auto;'>
            <div id='sql_results'>
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
