<?php session_start();
$electionid=$_SESSION['electionid'];
//If your session isn't valid, it returns you to the login screen for protection
if(empty($_SESSION['id'])){
 header("location:../index.php?error=notauthorised");
}
// print_r($_GET);
 // push candidate data to database
  // check if the 'voterid' variable is set in URL
  if (isset($_GET['voterid'])){
    // echo 'dd';
    require "../connection.php";
      // get id value
      $voterid = $_GET['voterid'];
      $candidate_motto = $_GET['candidate_motto'];
      // print_r($_GET);die;
      // to get voter information from database
      $sql="SELECT * from voter WHERE voter_id= '$voterid' ";
      $voterdetail=mysqli_query($db,$sql);
      if ($voterdetail==false) {
        echo "Failed to get voter information 2<br>";
        echo "SQL error :".mysqli_error($db);
        exit();
      }

      $rekod=mysqli_fetch_array($voterdetail);
      $voter_id =$rekod['voter_id'];
      $voter_name =$rekod['voter_name'];
      $voter_faculty =$rekod['faculty'];
      // insert voter data into candidate table in DB
      $sql="INSERT INTO candidate (voter_id,section_id,election_id,candidate_motto) VALUES ('$voterid','0','$electionid','$candidate_motto')";
      $qr=mysqli_query($db,$sql);

      if ($qr==true){
        // get candidate id from database
        $candidate_id = mysqli_insert_id($db);
        // to add into count database
        $sql="INSERT INTO count (candidate_id,section_id,election_id) VALUES ('$candidate_id','0','$electionid')";
        $qr=mysqli_query($db,$sql);
        if ($qr==false) {
          echo "Failed to add candidate to count table<br>";
          echo "SQL error :".mysqli_error($db);
          exit();
        } 
        // redirect to candidate list page after succesfully insett data into DB 
        header('Location: candidateumum.php');
      }
      else{
      echo "Fail to add as candidate for $voterid";
      echo mysqli_error($db);
      }
      // redirect back to candidates
        // header("Location: candidateumum.php");
   }
   else
   echo "voter id not exist";
include "include/header.template.php";

?>
  