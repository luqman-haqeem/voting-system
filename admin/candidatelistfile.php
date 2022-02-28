<?php session_start();
$electionid=$_SESSION['electionid'];

if(empty($_SESSION['id'])){
 header("location:../index.php");
}
if (isset($_POST['btn_add_candidate_file'])) {

    // get voter information
    $candidate_file=$_POST['candidate_file'];
	
	$target_dir = "uploads/";
	$target_file = $target_dir . basename($_FILES["candidate_file"]["name"]);
	$uploadOk = 1;
	$imageFileType = strtolower(pathinfo($target_file,PATHINFO_EXTENSION));

	// Check if image file is a actual image or fake image
	if(isset($_POST["submit"])) {
	  $check = getimagesize($_FILES["candidate_file"]["tmp_name"]);
	  if($check !== false) {
		$msg =  "File is an PDF - " . $check["mime"] . ".";
		$uploadOk = 1;
	  } else {
		$msg = "File is not an PDF.";
		$uploadOk = 0;
	  }
	}
	// Allow certain file formats
	if($imageFileType != "pdf" ) {
	  $msg = "Sorry, only PDF files are allowed.";
	  $uploadOk = 0;
	}
	// Check if $uploadOk is set to 0 by an error
	if ($uploadOk == 0) {
	  $msg = "Sorry, your file was not uploaded.";
	// if everything is ok, try to upload file
	} else {
	  if (move_uploaded_file($_FILES["candidate_file"]["tmp_name"], $target_file)) {
		$msg = "The file ". htmlspecialchars( basename( $_FILES["candidate_file"]["name"])). " has been uploaded.";
		// Update file name in DB
		$sql_updatefilename = "UPDATE candidate_filename SET file_name = '$target_file' ,updated_at = NOW() WHERE id = 1";
		if( !mysqli_query($db,$sql_updatefilename) ){
			echo "Failed to update file name<br>";
            echo "SQL error :".mysqli_error($db);
		}else{
			header('Location: candidatelistfile.php?succes=updated');

		}
		
		
	  } else {
		$msg = "Sorry, there was an error uploading your file.";
	  }
	}
	
	


    //to if check matric no exist in database
    $data_in_DB = mysqli_query($db,"SELECT matric_no FROM voter WHERE matric_no='$votermatricno' ") or die(mysql_error());
    if (mysqli_num_rows($data_in_DB)==0) {
        // insert voter information in voter and login table
        $querytovotertable="INSERT INTO voter  (voter_name,matric_no,faculty) 
                            VALUES('$votername','$votermatricno','$voterfaculty')";
        $qr=mysqli_query($db,$querytovotertable);
        if ($qr==false) {
            echo "Failed to add voter<br>";
            echo "SQL error :".mysqli_error($db);
        }
        else
            header('Location: addvoter.php?succes=addvoter');
    }
    else
      // if voter exist in DB
        header('Location: addvoter.php?error=alreadyexist');

}

include "include/header.template.php";
?>
        <div class="container-fluid">

             <div class="card shadow mb-4">

            <div class="card-header py-3" >
              <div class="d-sm-flex align-items-center justify-content-between mb-1">
                <h5 class="m-0  font-weight-bold text-primary">Candidate File</h5>
              </div>
           </div>
            <div class="card-body">
              <form class="user" method="post" action="<?php echo htmlentities($_SERVER['PHP_SELF']); ?>" enctype="multipart/form-data">

                    <!-- align left for label  -->
                    <div align="left">
                      <div class="form-row">
                        <!-- Matric no textbox -->
                        <div class="form-group col-md-3">
                          <label for="matric_no">Upload Candidate File</label>
                          <input name="candidate_file" type="file" class="form-control-file" id="candidate_file" accept="application/pdf,application/vnd.ms-excel" required="" >
                        </div>
                        <div class="col-md-2" >
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
	$(document).ready(function () {
$('#dtBasicExample').DataTable();
$('.dataTables_length').addClass('bs-select');
});
</script>

