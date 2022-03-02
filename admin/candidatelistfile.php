<?php session_start();
require '../connection.php';
include "../alertfunction.php";

$electionid = $_SESSION['electionid'];

if (empty($_SESSION['id'])) {
  header("location:../index.php");
}
if (isset($_POST['btn_add_candidate_file'])) {

  // get voter information
  $candidate_file = $_POST['candidate_file'];

  $target_dir = "uploads/";
  $target_file = $target_dir . basename($_FILES["candidate_file"]["name"]);
  $uploadOk = 1;
  $imageFileType = strtolower(pathinfo($target_file, PATHINFO_EXTENSION));


  // Allow certain file formats
  if ($imageFileType != "pdf") {
    $msg = "Sorry, only PDF files are allowed.";
    $uploadOk = 0;
  }
  // Check if $uploadOk is set to 0 by an error
  if ($uploadOk == 0) {
    $msg = "Sorry, your file was not uploaded.";
    // if everything is ok, try to upload file
  } else {
    if (move_uploaded_file($_FILES["candidate_file"]["tmp_name"], $target_file)) {
      $msg = "The file " . htmlspecialchars(basename($_FILES["candidate_file"]["name"])) . " has been uploaded.";
      // Update file name in DB
      $sql_updatefilename = "UPDATE candidate_filename SET file_name = '$target_file' ,updated_at = NOW() WHERE id = 1";
      if (!mysqli_query($db, $sql_updatefilename)) {
        echo "Failed to update file name<br>";
        echo "SQL error :" . mysqli_error($db);
        die;
      } else {
        header('Location: candidatelistfile.php?success=updated');
      }
    } else {
      header('Location: candidatelistfile.php?error=failed');
    }
  }
}

include "include/header.template.php";
?>
<div class="container-fluid">

  <div class="card shadow mb-4">
    <div class="card-header py-3">
      <div class="d-sm-flex align-items-center justify-content-between mb-1">
        <h5 class="m-0  font-weight-bold text-primary">Candidate File</h5>
      </div>
    </div>
    <div class="card-body">
      <div class="p-2">
        <?php
        // success handling for searchbox
        if (isset($_GET['success'])) {
          if ($_GET['success'] == "updated") {
            successwithclose("Successfully Upload file");
          }
        } elseif (isset($_GET['error'])) {
          if ($_GET['error'] == "norecordfund") {
            alertwithclose("No record found for: " . $search_name);
          }
          if ($_GET['error'] == "failed") {
            alertwithclose("Something When Wrong, Please Try Again Later ");
          }
        }
        ?>
      </div>
      <form class="user" method="post" action="<?php echo htmlentities($_SERVER['PHP_SELF']); ?>" enctype="multipart/form-data">

        <!-- align left for label  -->
        <div align="left">
          <div class="form-row">
            <!-- Matric no textbox -->
            <div class="form-group col-md-3">
              <label for="matric_no">Upload Candidate File</label>
              <input name="candidate_file" type="file" class="form-control-file" id="candidate_file" accept="application/pdf,application/vnd.ms-excel" required="">
            </div>
            <div class="col-md-2">
              <input class="btn btn-primary btn-user btn-block" type="submit" name="btn_add_candidate_file" value="Submit">
            </div>

          </div>
        </div>
      </form>
    </div>

    <hr>

    <?php
    include "include/footer.template.php";
    ?>

    <script>
      $(document).ready(function() {
        $('#dtBasicExample').DataTable();
        $('.dataTables_length').addClass('bs-select');
      });
    </script>