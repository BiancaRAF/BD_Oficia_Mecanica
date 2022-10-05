select  servPrestado,count(*) 'Qtd. Serviço', sum(valorServico) 'Valor total' from tipoServico group by servPrestado;

select * from os inner join cliente using(idCliente) 
				 inner join veiculo using(idOS)
                 inner join relVeiculoEstado using(idVeiculo) 
                 where relVeiculoEstado.statusObra like 'Concluída';
                 
update os set statusOS = 'Finalizada' where idOS in (2, 3, 4);