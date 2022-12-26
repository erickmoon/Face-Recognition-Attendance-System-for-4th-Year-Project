
<style>
	.collapse a{
		text-indent:10px;
	}
	@font-face {
    font-family: sfprodisplay;
    src: url("assets/fonts/SFPRODISPLAYREGULAR.OTF") format("opentype");
	}


	nav#sidebar{
		/*background: url(assets/uploads/<?php echo $_SESSION['system']['cover_img'] ?>) !important*/
	}
	.nav-item-text{
		font-size: 13px;
	}

</style>

<nav id="sidebar" class='mx-lt-5 bg-dark' style="background: white;">
		
		<div class="sidebar-list" style="background: white; margin-top: 10px; font-weight: 100;">
				<a href="index.php?page=home" class="nav-item nav-item-text nav-home">
				<span class='icon-field'>
					<img src="assets/uploads/ic_dashboard.png" style="height: 22px; width: auto; margin-right: 8px; filter: invert(48%) sepia(13%) saturate(3207%) hue-rotate(130deg) brightness(95%) contrast(80%);">
				</span> Dashboard</a>
				<?php if($_SESSION['login_faculty_id'] <= 0): ?>
				<a href="index.php?page=courses" class="nav-item nav-item-text nav-courses"><span class='icon-field'><img src="assets/uploads/ic_course.png" style="height: 22px; width: auto; margin-right: 8px; filter: invert(48%) sepia(13%) saturate(3207%) hue-rotate(130deg) brightness(95%) contrast(80%);"></span> Course</a>
				<a href="index.php?page=units" class="nav-item nav-item-text nav-units"><span class='icon-field'><img src="assets/uploads/ic_unit.png" style="height: 22px; width: auto; margin-right: 8px; filter: invert(48%) sepia(13%) saturate(3207%) hue-rotate(130deg) brightness(95%) contrast(80%);"></span> Units</a>
				<a href="index.php?page=class" class="nav-item nav-item-text nav-class"><span class='icon-field'><img src="assets/uploads/ic_class.png" style="height: 22px; width: auto; margin-right: 8px; filter: invert(48%) sepia(13%) saturate(3207%) hue-rotate(130deg) brightness(95%) contrast(80%);"></span> Class</a>
				<a href="index.php?page=faculty" class="nav-item nav-item-text nav-faculty"><span class='icon-field'><img src="assets/uploads/ic_faculty.png" style="height: 22px; width: auto; margin-right: 8px; filter: invert(48%) sepia(13%) saturate(3207%) hue-rotate(130deg) brightness(95%) contrast(80%);"></span> Faculty</a>
				<a href="index.php?page=students" class="nav-item nav-item-text nav-students"><span class='icon-field'><img src="assets/uploads/ic_student.png" style="height: 22px; width: auto; margin-right: 8px; filter: invert(48%) sepia(13%) saturate(3207%) hue-rotate(130deg) brightness(95%) contrast(80%);"></span> Student</a>
				<a href="index.php?page=class_unit" class="nav-item nav-item-text nav-class_unit"><span class='icon-field'><img src="assets/uploads/ic_class_unit.png" style="height: 22px; width: auto; margin-right: 8px; filter: invert(48%) sepia(13%) saturate(3207%) hue-rotate(130deg) brightness(95%) contrast(80%);"></span> Class per unit</a>
				<?php endif; ?>
				<a href="index.php?page=check_attendance" class="nav-item nav-item-text nav-check_attendance"><span class='icon-field'><img src="assets/uploads/ic_take_attendance.png" style="height: 22px; width: auto; margin-right: 8px; filter: invert(48%) sepia(13%) saturate(3207%) hue-rotate(130deg) brightness(95%) contrast(80%);"></span> Take Attendance</a>
				<a href="index.php?page=attendance_record" class="nav-item nav-item-text nav-attendance_record"><span class='icon-field'><img src="assets/uploads/ic_attendance_report.png" style="height: 22px; width: auto; margin-right: 8px; filter: invert(48%) sepia(13%) saturate(3207%) hue-rotate(130deg) brightness(95%) contrast(80%);"></span> Attendance Record</a>
				<a href="index.php?page=attendance_report" class="nav-item nav-item-text nav-attendance_report"><span class='icon-field'><img src="assets/uploads/ic_report.png" style="height: 22px; width: auto; margin-right: 8px; filter: invert(48%) sepia(13%) saturate(3207%) hue-rotate(130deg) brightness(95%) contrast(80%);"></span> Attendance Report</a>
				<?php if($_SESSION['login_type'] == 1): ?>
				<a href="index.php?page=users" class="nav-item nav-item-text nav-users"><span class='icon-field'><img src="assets/uploads/ic_users.png" style="height: 22px; width: auto; margin-right: 8px; filter: invert(48%) sepia(13%) saturate(3207%) hue-rotate(130deg) brightness(95%) contrast(80%);"></span> Users</a>
				<!-- <a href="index.php?page=site_settings" class="nav-item nav-item-text nav-site_settings"><span class='icon-field'><i class="fa fa-cogs text-danger"></i></span> System Settings</a> -->
			<?php endif; ?>
		</div>

</nav>
<script>
	$('.nav_collapse').click(function(){
		console.log($(this).attr('href'))
		$($(this).attr('href')).collapse()
	})
	$('.nav-<?php echo isset($_GET['page']) ? $_GET['page'] : '' ?>').addClass('active')
</script>
