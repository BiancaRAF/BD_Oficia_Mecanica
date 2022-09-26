-- Cláusulas para popular o BD 
insert into cliente values
(1, 'Ana Beatriz K Silva', '27549736057', '18973371124', '18973371333', 'anabea@gmail.com'),
(2, 'Carol J Santos', '07516164003', '17974352553', '15972273289', 'carol@outlook.com'),
(3, 'Roberto V Oliveira', '55043430036', '16986601254', '17980760143', 'roberto@gmail.com'),
(4, 'Anderson Jackson A Oliveira', '43646239034', '15968117156', '16986086785', 'anderson@gmail.com'),
(5, 'Júlio Oliveira Costa', '37852891039', '19982438566', '18974711252', 'julio@yahoo.com');

insert into os values
(1, 1, 'Problema na embreagem', default, '2022-09-01'),
(2, 2, 'Problema na porta', default, '2022-09-10'),
(3, 1, 'Revisão', default, '2022-09-01'),
(4, 3, 'Problema na rodas', default, '2022-09-07'),
(5, 4, 'Troca de óleo', default, '2022-09-11'),
(6, 5, 'Batida frontal', default, '2022-09-20'),
(7, 3, 'Problema no motor', default, '2022-09-23');

insert into relVeiculoEstado values 
(1, 1, 'Iniciado'),
(2, 2, 'Concluída'),
(3, 3, 'Iniciado'),
(4, 4, 'Concluída'),
(5, 5, 'Concluída'),
(6, 6, default),
(7, 7, 'Iniciado');

insert into estadoVeiculo values 
(1, 'Caixa de embreagem', '2022-09-30'),
(2, 'Trocar maçaneta', '2022-09-20'),
(3, 'Revisão', '2022-09-30'),
(4, 'Troca de câmara de ar', '2022-09-10'),
(5, 'Troca de óleo', '2022-09-11'),
(6, 'Reformar e revisão', '2022-09-27'),
(7, 'Falha na injeção eletrônica', '2022-10-05'); 



insert into relServicoEstado values 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7);

insert relPecaEstado values 
(1, 1, default),
(2, 2, 4),
(3, 4, 3),
(4, 5, default),
(6, 6, default),
(5, 7, default);

insert into pecas values
(1, 'Caixa de embreagem', 600, 7),
(2, 'Maçaneta', 200, 15),
(3, 'Câmara de ar', 25, 42),
(4, 'Óleo para motor', 45, 56),
(5, 'Injeção eletrônica', 300, 27),
(6, 'Para-choque', 450, 18);

insert into tipoServico values
(1, default, 500),
(2, default, 200),
(3, 'Vistoria', 80),
(4, default, 60),
(5, default, 500),
(6, 'Ambos', 2500),
(7, default, 1200);

insert into veiculo values 
(1, 1, 1, 'Hyundai HB20', 'Preto', default, 'AHK-1547'),
(2, 2, 1, 'Chevrolet Onix', 'Cinza', default, 'FSV-5120'),
(3, 5, 1, 'Fiat Mobi', 'Branco', default, 'GBW-0145'),
(4, 3, 1, 'Fiat Argo', 'Branco', default, 'IHG-2010'),
(5, 4, 1, 'Volkswagen Gol', 'Branco', default, 'QDX-0522'),
(6, 7, 1, 'Hyundai HB20', 'Cinza', default, 'DFB-2514'),
(7, 6, 1, 'Hyundai HB20', 'Preto', default, 'JDS-5255');

insert into funcionario values
(1 , 'Carlos Alberto', 2200, 'Supervisor Operacional', 'CLT'),
(2, 'Júlios Fernandes', 4500, 'Mecânico', 'PJ'),
(3, 'Alberto Santos', 1300, 'Mecânico Júnior', 'CLT'),
(4, 'Fernando Gomes', 800, 'Estagiário', 'Estágio'),
(5, 'Júlia Augusta Leite', 1400, 'Caixa', 'CLT'),
(6, 'Junior Silveira', 1900, 'Mecânico Sênior', 'CLT'),
(7, 'Leonardo Carvalho', 1100, 'Balconista', 'CLT');

insert into equipeObra values
(1, 3),
(2, 5),
(3, 4);

insert into relEquipeFuncionarios values 
(2, 4),
(1, 1),
(2, 1),
(3, 1),
(1, 2),
(2, 2),
(3, 2),
(1, 3),
(2, 3),
(3, 4),
(2, 6),
(3, 6);