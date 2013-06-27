# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->

		$.extend( $.fn.dataTable.defaults, {
			sDom: '<"search-box"r><"H"lf>t<"F"ip>',
			sPaginationType: "full_numbers",
			bJQueryUI: true,
			oLanguage: {
				"sProcessing": "Procesando...",
				"sLengthMenu": "Mostrar _MENU_ registros",
				"sZeroRecords": "No se encontraron resultados",
				"sEmptyTable": "Ningún dato disponible en esta tabla",
				"sInfo": "Mostrando registros del _START_ al _END_ de un total de _TOTAL_ registros",
				"sInfoEmpty": "Mostrando registros del 0 al 0 de un total de 0 registros",
				"sInfoFiltered": "(filtrado de un total de _MAX_ registros)",
				"sInfoPostFix": "",
				"sSearch": "Buscar:",
				"sUrl": "",
				"sInfoThousands": ",",
				"sLoadingRecords": "Cargando...",
				"oPaginate": {
					"sFirst": "Primero",
					"sLast": "Último",
					"sNext": "Siguiente",
					"sPrevious": "Anterior"
				},
				"oAria": {
					"sSortAscending": ": Activar para ordenar la columna de manera ascendente",
					"sSortDescending": ": Activar para ordenar la columna de manera descendente"
				}
			}
		} );

		for i in [0..gon.instance[0]] by 1
			$('#cavities_' + i.toString()).dataTable()
			$('#batch_time_' + i.toString()).dataTable()

		$('#products_composition').dataTable()
		$('#install_time').dataTable()
		$('#velocity').dataTable()
		$('#demand').dataTable()
		$('#machine_time').dataTable()

