<?php include('db_connect.php');?>

<div class="container-fluid">
	
	<div class="col-lg-12">
		<div class="row mb-4 mt-4">
			<div class="col-md-12">
				
			</div>
		</div>
		<div class="row">
			<!-- FORM Panel -->

			<!-- Table Panel -->
			<div class="col-md-12">
				<div class="card">
					<div class="card-header">
						<b>List of Class per unit</b>
						<span class="float:right"><a class="btn btn-primary btn-block btn-sm col-sm-2 float-right" href="javascript:void(0)" id="new_class_unit">
					<i class="fa fa-plus"></i> New Entry
				</a></span>
					</div>
					<div class="card-body">
						<table class="table table-condensed table-bordered table-hover">
							<thead>
								<tr>
									<th class="text-center">#</th>
									<th class="">Class</th>
									<th class="">Unit</th>
									<th class="">Faculty</th>
									<th class="text-center">Action</th>
								</tr>
							</thead>
							<tbody>
								<?php 
								$i = 1;
								$class_unit = $conn->query("SELECT cs.*,concat(co.course,' ',c.level,'-',c.section) as `class`,s.unit,f.name as fname FROM class_unit cs inner join `class` c on c.id = cs.class_id inner join courses co on co.id = c.course_id inner join faculty f on f.id = cs.faculty_id inner join units s on s.id = cs.unit_id order by concat(co.course,' ',c.level,'-',c.section) asc");
								while($row=$class_unit->fetch_assoc()):
								?>
								<tr>
									<td class="text-center"><?php echo $i++ ?></td>
									<td>
										<p> <b><?php echo $row['class'] ?></b></p>
									</td>
									<td class="">
										 <p> <b><?php echo $row['unit'] ?></b></p>
									</td>
									<td class="">
										 <p> <b><?php echo $row['fname'] ?></b></p>
									</td>
									<td class="text-center">
										<button class="btn btn-sm btn-outline-primary edit_class_unit" type="button" data-id="<?php echo $row['id'] ?>" >Edit</button>
										<button class="btn btn-sm btn-outline-danger delete_class_unit" type="button" data-id="<?php echo $row['id'] ?>">Delete</button>
									</td>
								</tr>
								<?php endwhile; ?>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			<!-- Table Panel -->
		</div>
	</div>	

</div>
<style>
	
	td{
		vertical-align: middle !important;
	}
	td p{
		margin: unset
	}
	img{
		max-width:100px;
		max-height: :150px;
	}
</style>
<script>
	$(document).ready(function(){
		$('table').dataTable()
	})
	$('#new_class_unit').click(function(){
		uni_modal("New Entry","manage_class_unit.php","")
		
	})

	$('.edit_class_unit').click(function(){
		uni_modal("Manage Entry Details","manage_class_unit.php?id="+$(this).attr('data-id'),"")
		
	})
	$('.delete_class_unit').click(function(){
		_conf("Are you sure to delete this class unit?","delete_class_unit",[$(this).attr('data-id')])
	})
	
	function delete_class_unit($id){
		start_load()
		$.ajax({
			url:'ajax.php?action=delete_class_unit',
			method:'POST',
			data:{id:$id},
			success:function(resp){
				if(resp==1){
					alert_toast("Data successfully deleted",'success')
					setTimeout(function(){
						location.reload()
					},1500)

				}
			}
		})
	}
</script>