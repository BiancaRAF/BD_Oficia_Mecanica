-- Banco de Dados E-commerce

create database if not exists ecommerce;

use ecommerce;

-- tabela cliente ok

create table cliente(
	idCliente int auto_increment primary key,
    isCPF bool not null default true,
    fone_1_cliente varchar(14) not null,
    fone_2_cliente varchar(14),
    email_cliente varchar(25) not null
);

-- tabela conta PF ok

create table contaPF(
	idContaPF int auto_increment primary key,
    idCliente int,
    PNome varchar(20) not null,
    MNome varchar(5),
    Sobrenome varchar(20) not null,
    CPF_cliente char(11) not null,
    constraint unique_cpf_cliente unique(CPF_cliente),
    DataNasc date,
    constraint fk_idCliente_PF foreign key (idCliente) references cliente(idCliente)
);

-- tabela conta PJ ok

create table contaPJ(
	idContaPJ int auto_increment primary key,
    idCliente int,
    razaoSocial varchar(20) not null,
    CNPJ_cliente char(14) not null,
    constraint unique_cnpj_cliente unique(CNPJ_cliente),
    constraint fk_idCliente_PJ foreign key (idCliente) references cliente(idCliente)
);

-- tabela produto ok

create table produto(
	idProduto int auto_increment primary key,
    valor float not null,
    categoria enum('Alimentos', 'Eletrônicos', 'Vestimenta', 'Diversos', 'Brinquedos') not null default 'Diversos',
    descricaoProduto varchar(45) not null,
    avaliacao int not null default 0,
    constraint chk_avaliacao check(avaliacao >= 0 or avaliacao <= 5),
    infantil bool,
    pesoProduto float not null,
    alturaProduto float not null,
    comprimentoProduto float not null
);

-- tabela entrega ok

create table entrega(
	idEntrega int auto_increment primary key,
    logradouro varchar(20) not null,
    numero varchar(5) not null,
    bairro varchar(15) not null,
    cidade varchar(15) not null,
	estado varchar(2) not null,
    pais varchar(15) not null,
    CEP varchar(10) not null,
	complemento varchar(25),
    codRastreio varchar(25) not null
);

-- tabela pedido ok

create table pedido(
	idPedido int auto_increment primary key,
    idCliente_Pedido int,
    idPedido_Entrega int,
    statusPedido enum('Análise', 'Enviado', 'Entregue', 'Cancelado', 'Em andamento', 'Processando') not null default 'Processando',
    descricaoPedido varchar(45),
    constraint fk_idCliente_Pedido foreign key (idCliente_Pedido) references cliente(idCliente)
		on delete cascade
        on update cascade,
    constraint fk_idEntrega_Pedido foreign key (idPedido_Entrega) references entrega(idEntrega)
		on delete cascade
        on update cascade
);

-- tabela fornecedor ok

create table fornecedor(
	idFornecedor int auto_increment primary key,
    razaoSocial_forn varchar(20) not null,
    CNPJ_fornecedor char(14) not null,
    constraint unique_cnpj_fornecedor unique(CNPJ_fornecedor),
    fone_1_forn varchar(14) not null,
    fone_2_forn varchar(14),
    email_forn varchar(20) not null,
    endereco_forn varchar(45)
);

-- tabela estoque ok

create table estoque(
	idEstoque int auto_increment primary key,
    endereco_estq varchar(45) not null,
    ticketDeposito_estq varchar(20) not null,
    constraint unique_ticket_dep unique(ticketDeposito_estq)
);

-- tabela Vendedor Terceirizado ok

create table vendTerceirizado(
	idVendTerceirizado int auto_increment primary key,
    razaoSocial_Terc varchar(20) not null,
    endereco_Terc varchar(45) not null,
    nomeFantasia_Ter varchar(20) not null,
    CNPJ_Terc char(14) not null,
    constraint unique_cnpj_terc unique(CNPJ_terc),
    fone_1_Terc varchar(14) not null,
    fone_2_Terc varchar(14),
    email_Terc varchar(20) not null
);

-- tabela Pagamento ok

create table pagamento(
	idPagamento int auto_increment primary key,
    idPagPedido int,
    tipoPagamento enum('Boleto', 'Débito', 'Cartão de Crédito', 'PIX') not null default 'Cartão de Crédito',
	valorProd float not null,
    valorFrete float not null,
    constraint fk_pagamento_pedido foreign key (idPagPedido) references pedido(idPedido)
		on delete cascade
        on update cascade
);

-- tabela Cartão ok

create table cartao(
	idCartao int auto_increment primary key,
	numero varchar(16),
    mesVenc char(2),
    anoVenc char(2),
    CPF_Dono char(11) not null
);

-- Tabelas com foreign keys (tabelas auxiliares)


-- Tabela do relacionamento Produto e Fornecedor ok

create table relProdutoFornecedor(
	idRelFornecedor int,
    idRelProduto int,
    primary key(idRelFornecedor, idRelProduto),
	constraint fk_rel_forn foreign key (idRelFornecedor) references fornecedor(idFornecedor)
		on delete cascade
        on update cascade,
	constraint fk_rel_prod foreign key (idRelProduto) references produto(idProduto)
		on delete cascade
        on update cascade,
    qtdProdForn int not null,
    constraint chk_qtdProdForn check(qtdProdForn >= 0),
	statusProdForn enum('Disponível', 'Sem estoque', 'Indisponível') not null default 'Disponível'
);

-- Tabela do relacionamento Produto e Vendedor ok

create table relProdutoVendedor(
	idRelVendedor int,
    idRelProduto int,
    primary key(idRelVendedor, idRelProduto),
	constraint fk_rel_vend foreign key (idRelVendedor) references vendTerceirizado(idVendTerceirizado)
		on delete cascade
        on update cascade,
	constraint fk_rel_prod_vend foreign key (idRelProduto) references produto(idProduto)
		on delete cascade
        on update cascade,
    qtdProdVend int not null,
    constraint chk_qtdProdVend check(qtdProdVend >= 0),
	statusProdVend enum('Disponível', 'Sem estoque', 'Indisponível') not null default 'Disponível'
);

-- Tabela do relacionamento Produto e Estoque ok

create table relProdutoEstoque(
	idRelEstoque int,
    idRelProduto int,
    primary key(idRelEstoque, idRelProduto),
	constraint fk_rel_estq foreign key (idRelEstoque) references estoque(idEstoque)
		on delete cascade
        on update cascade,
	constraint fk_rel_prod_estq foreign key (idRelProduto) references produto(idProduto)
		on delete cascade
        on update cascade,
    qtdProdEstq int not null,
    constraint chk_qtdProdEstq check(qtdProdEstq >= 0),
	statusProdEstq enum('Disponível', 'Sem estoque', 'Indisponível') not null default 'Disponível'
);

-- Tabela do relacionamento Produto e Pedido ok

create table relProdutoPedido(
	idRelPedido int,
    idRelProduto int,
    primary key(idRelPedido, idRelProduto),
	constraint fk_rel_Pedido foreign key (idRelPedido) references pedido(idPedido)
		on delete cascade
        on update cascade,
	constraint fk_rel_prod_pedido foreign key (idRelProduto) references produto(idProduto)
		on delete cascade
        on update cascade,
    qtdProdPedido int not null,
    constraint chk_qtdProdPedido check(qtdProdPedido >= 1)
);

-- Tabela do relacionamento Pagamento se cartão ok

create table relPagamentoCartao(
	idRelPagamento int,
    idRelCartao int,
    primary key(idRelPagamento, idRelCartao),
	constraint fk_rel_Pagamento foreign key (idRelPagamento) references pagamento(idPagamento)
		on delete cascade
        on update cascade,
	constraint fk_rel_Cartao foreign key (idRelCartao) references cartao(idCartao)
		on delete cascade
        on update cascade
);

