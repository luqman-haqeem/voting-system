<?php session_start();
  require '../connection.php';

//If your session isn't valid, it returns you to the login screen for protection
if(empty($_SESSION['id'])){
 header("location:../index.php?error=alreadylogout");
}
// update when confrim button is selected
if (isset($_POST['btn_updatevoter'])) {
  $candidate_id=$_POST['candidate_id'];
  $motto=$_POST['candidate_motto'];

$qr=mysqli_query($db,"UPDATE candidate SET candidate_motto ='$motto' WHERE candidate_id='$candidate_id' ");
if ($qr==false) {
  echo "Failed to update candidate information<br>";
  echo "SQL error :".mysqli_error($db);
}
else
header('Location:voterlist.php?success=updated');
}
// get election id from session 
$electionid=$_SESSION['electionid'];

$candidate_id=$_GET['candidate_id'];
$query ="SELECT v.*,f.* FROM voter AS v
        JOIN candidate AS c
         ON v.voter_id =c.voter_id
         JOIN faculty AS f
         ON v.faculty =f.faculty_id
         WHERE c.candidate_id'$candidate_id' ";

$qr=mysqli_query($db,$query);
if ($qr==false) {
  echo "Failed to get candidate information<br>";
  echo "SQL error :".mysqli_error($db);
}
$record=mysqli_fetch_array($qr);

$total_faculty=mysqli_query($db,"SELECT * FROM faculty");
if ($qr==false) {
  echo "Failed to get faculty information<br>";
  echo "SQL error :".mysqli_error($db);
}

include "include/header.template.php";
?>
          <!-- Align element to center -->
          <div align="center">
            <!-- Card element  -->
            <div class="col-xl-7 col-lg-7">
              <div class="card shadow mb-4">
                <!-- Card Header -->
                <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                  <h6 class="m-0 font-weight-bold text-primary">Edit candidate Information</h6>
                  <!-- End Card Header -->
                </div>
                <!-- Card Body -->
                <div class="card-body">
                  <form class="user" method="POST" action="<?php echo htmlentities($_SERVER['PHP_SELF']); ?>">

                    <!-- align left for label  -->
                    <div align="left">
                     <!-- NAME textbox -->
                      <div class="form-group">
                          <label  for="title" >Candidate name</label>
                          <input name="candidate_name" type="text"  class="form-control" id="candidate_name" value="<?=$record['voter_name']?>" placeholder="Candidate Name" readonly>
                        </div>
                      <div class="form-row">
                        <!-- motto textbox -->
                        <div class="form-group col-md-6">
                          <label for="matric_no">Candidate Motto</label> 
                          <input name="candidate_motto" type="text" class="form-control " id="candidate_motto" value="<?=$record['matric_no']?>" placeholder="Motto" >
                        </div>
                        
                     </div>
                    </div>
                    <div align="right">
                      <div class="col-md-3" >
                          <input class="btn btn-primary btn-user btn-block" type="submit" name="btn_updatevoter" value="Update">
                      </div>
                    </div>
                  </form>
                  
                </div>
              </div>
              <!-- Card element end -->
            </div>
          <!-- Align element to center end -->
          </div>
<?php
include "include/footer.template.php";
?>