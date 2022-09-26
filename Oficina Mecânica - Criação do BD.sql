create database if not exists oficinaMecanica;

-- drop database oficinaMecanica;

use oficinaMecanica;

-- Tabela cliente ok

create table cliente(
	idCliente int auto_increment primary key,
    nomeCliente varchar(45) not null,
    CPF_cliente varchar(11) not null,
    contatoCliente_1 varchar(14) not null,
    contatoCliente_2 varchar(14),
    emailCliente varchar(40)
);

-- Tabela Ordem de Serviço ok

create table OS(
	idOS int auto_increment primary key,
    idCliente int,
    descricaoOS varchar(100), -- descrição realizada pelo cliente
    statusOS enum('Autorizada', 'Recusada pelo cliente', 'Finalizada', 'Aguardando Autorização','Pendente da mão de obra', 'Pendente avaliação profissional','Em execução', 'Parada falta de peça', 'Parada outro problema') not null default 'Pendente avaliação profissional',
    dataEmissao date not null,
    constraint fk_idcliente_OS foreign key (idCliente) references cliente(idCliente)
		on update cascade
        on delete cascade
);

-- Tabela Equipe Mão de Obra ok

create table equipeObra(
	idEquipeObra int auto_increment primary key,
    qtdFuncionario int not null default 1
);

-- Tabela Veículo ok

create table veiculo(
	idVeiculo int auto_increment primary key,
    idOS int,
    idEquipeObra int,
    modelo varchar(25) not null,
    cor varchar(25) not null,
    qtdPortas int default 4,
    placa varchar(10) not null,
    constraint fk_idOS_veiculo foreign key (idOS) references OS(idOS)
		on update cascade
        on delete cascade,
    constraint fk_idEquipeObra_veiculo foreign key (idEquipeObra) references equipeObra(idEquipeObra)
		on update cascade
        on delete cascade
);

-- Tabela Funcionários ok 

create table funcionario(
	idFuncionario int auto_increment primary key,
    nomeFuncionario varchar(45) not null,
    salario float not null,
    cargo varchar(25) not null,
    regime enum('CLT', 'PJ', 'Contrato', 'Estágio', 'Terceirizado') not null default 'CLT'
);

-- Tabela Situação Veículo ok

create table estadoVeiculo(
	idEstadoVeiculo int auto_increment primary key,
    detalharProblema varchar(100) not null, -- descrição do profissional
    dataEntrega date not null
);

-- Tabela Tipo Serviço ok

create table tipoServico(
	idTipoServico int auto_increment primary key,
    servPrestado enum('Conserto', 'Vistoria', 'Ambos') not null default 'Conserto', 
    valorServico float not null
);

-- Tabela Peças 

create table pecas(
	idPecas int auto_increment primary key,
    nomePeca varchar(20) not null,
    valorPeca float not null,
    qtdPeca int not null default 1
);

-- -- -- -- Tabelas de relacionamentos -- -- -- --

-- Relacionamento Funcionarios x Equipe mão de obra ok

create table relEquipeFuncionarios(
	idEquipeObra int,
    idFuncionario int,
    constraint fk_idEquipeObra_rel_func foreign key (idEquipeObra) references equipeObra(idEquipeObra)
		on update cascade
        on delete cascade,
    constraint fk_idFuncionario_rel_Equipe foreign key (idFuncionario) references funcionario(idFuncionario)
		on update cascade
        on delete cascade
);

-- Relacionamento Veículo x Estado Veículo ok

create table relVeiculoEstado(
	idVeiculo int,
    idEstadoVeiculo int,
    constraint fk_idVeiculo_Estado foreign key (idVeiculo) references veiculo(idVeiculo)
		on update cascade
        on delete cascade,
    constraint kf_idEstadoVeiculo_Veiculo foreign key (idEstadoVeiculo) references estadoVeiculo(idEstadoVeiculo)
		on update cascade
        on delete cascade,
    statusObra enum('Iniciado', 'Análise', 'Parada', 'Concluída', 'Pendente') not null default 'Pendente'
);

-- Relacionamento Serviço x Estado Veículo ok

create table relServicoEstado(
	idTipoServico int,
    idEstadoVeiculo int,
    constraint fk_idServico_Estado foreign key (idTipoServico) references tipoServico(idTipoServico)
		on update cascade
        on delete cascade,
    constraint kf_idEstadoVeiculo_Servico foreign key (idEstadoVeiculo) references estadoVeiculo(idEstadoVeiculo)
		on update cascade
        on delete cascade
);

-- Relacionamento Peças x Estado Veículo ok

create table relPecaEstado(
	idPecas int,
    idEstadoVeiculo int,
    constraint fk_idPecas_Estado foreign key (idPecas) references pecas(idPecas)
		on update cascade
        on delete cascade,
    constraint kf_idEstadoVeiculo_Pecas foreign key (idEstadoVeiculo) references estadoVeiculo(idEstadoVeiculo)
		on update cascade
        on delete cascade,
	qtdPeca_cliente int not null default 1
);
