<?php include('db_connect.php');?>

<div class="container-fluid">
	
	<div class="col-lg-12">
		<div class="row">
			<!-- FORM Panel -->
			<div class="col-md-4">
			<form action="" id="manage-unit">
				<div class="card">
					<div class="card-header">
						    unit Form
				  	</div>
					<div class="card-body">
							<input type="hidden" name="id">
							<div id="msg"></div>
							<div class="form-group">
								<label class="control-label">unit</label>
								<input type="text" class="form-control" name="unit">
							</div>
							<div class="form-group">
								<label class="control-label">Description</label>
								<textarea name="description" id="" cols="30" rows="4" class="form-control"></textarea>
							</div>
					</div>
							
					<div class="card-footer">
						<div class="row">
							<div class="col-md-12">
								<button class="btn btn-sm btn-primary col-sm-3 offset-md-3"> Save</button>
								<button class="btn btn-sm btn-default col-sm-3" type="reset"> Cancel</button>
							</div>
						</div>
					</div>
				</div>
			</form>
			</div>
			<!-- FORM Panel -->

			<!-- Table Panel -->
			<div class="col-md-8">
				<div class="card">
					<div class="card-header">
						<b>unit List</b>
					</div>
					<div class="card-body">
						<table class="table table-bordered table-hover">

							<thead>
								<tr>
									<th class="text-center" width="5%">#</th>
									<th class="text-center">unit</th>
									<th class="text-center" width="25%">Action</th>
								</tr>
							</thead>
							<tbody>
								<?php 
								$i = 1;
								$unit = $conn->query("SELECT * FROM units order by id asc");
								while($row=$unit->fetch_assoc()):
								?>
								<tr>
									<td class="text-center"><?php echo $i++ ?></td>
									<td class="">
										<p><b><?php echo ucwords($row['unit']) ?></b></p>
										<small><i><?php echo $row['description'] ?></i></small>
									</td>
									<td class="text-center">
										<button class="btn btn-sm btn-primary edit_unit" type="button" data-id="<?php echo $row['id'] ?>"  data-unit="<?php echo $row['unit'] ?>"  data-description="<?php echo $row['description'] ?>" >Edit</button>
										<button class="btn btn-sm btn-danger delete_unit" type="button" data-id="<?php echo $row['id'] ?>">Delete</button>
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
	td p {
	    margin: unset;
	}
</style>
<script>
	
	$('#manage-unit').on('reset',function(){
		$('#msg').html('')
		$('input:hidden').val('')
	})
	$('#manage-unit').submit(function(e){
		e.preventDefault()
		$('#msg').html('')
		start_load()
		$.ajax({
			url:'ajax.php?action=save_unit',
			data: new FormData($(this)[0]),
		    cache: false,
		    contentType: false,
		    processData: false,
		    method: 'POST',
		    type: 'POST',
			success:function(resp){
				if(resp==1){
					alert_toast("Data successfully saved",'success')
					setTimeout(function(){
						location.reload()
					},1500)

				}else if(resp == 2){
				$('#msg').html('<div class="alert alert-danger mx-2">unit already exist.</div>')
				end_load()
				}				
			}
		})
	})
	$('.edit_unit').click(function(){
		start_load()
		var cat = $('#manage-unit')
		cat.get(0).reset()
		cat.find("[name='id']").val($(this).attr('data-id'))
		cat.find("[name='name']").val($(this).attr('data-name'))
		cat.find("[name='description']").val($(this).attr('data-description'))
		end_load()
	})
	$('.delete_unit').click(function(){
		_conf("Are you sure to delete this unit?","delete_unit",[$(this).attr('data-id')])
	})
	function delete_unit($id){
		start_load()
		$.ajax({
			url:'ajax.php?action=delete_unit',
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
	$('table').dataTable()
</script>