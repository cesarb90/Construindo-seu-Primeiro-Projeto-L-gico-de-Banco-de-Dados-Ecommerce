-- criação do banco de dados para o cenário de E-commerce
-- drop database ecommerce;
create database ecommerce;
use ecommerce;

-- criar tabela cliente

create table client (
	idClient int auto_increment primary key,
    Fname varchar(10),
    Minit char(3),
    Lname varchar(20),
    CPF char(11) not null,
    Address varchar(230),
    constraint unique_cpf_client unique (CPF)
);
    
-- criando tabela de Produto
create table product(
	idProduct int auto_increment primary key,
    Pname varchar(10),
    classification_kids bool default false,
    category enum('Eletrônico','Vestimenta','Brinquedos','Alimentos','Moveis') not null,
    avaliação float default 0,
    size varchar(10)
);
    
    
    
-- criando tabela pedido
create table orders(
	idOrder int auto_increment primary key,
    idOrderClient int,
    orderStatus enum ('Cancelado','Confirmado','Em Processamento') default 'Em Processamento',
    orderDescription varchar(255),
    sendValue float default 10,
    paymentCash bool default false,
	constraint fk_order_client foreign key(IdOrderClient) references client(idClient)
		on update cascade
);
    desc orders;
    
create table productOrder(
	idPOproduct int,
    idPOorder int,
    poQuantity int default 1,
    poStatus enum('Disponível','Sem estoque') default 'Disponível',
    primary key (idPOproduct, IdPOorder),
    constraint fk_productorder_seller foreign key (idPOproduct) references product(idProduct),
    constraint fk_productorder_product foreign key (IdPOorder) references orders(idOrder)
);
    
 -- drop table payments;
    create table payments (
	idPayClient int,
    idPayment int,
    typePayment enum('Boleto','Cartão','Dois cartões'),
    statusPayment enum('Esperando Pagamento','Pagamento Aceito','Pagamento Cancelado'),
    limitAvailable float,
    primary key (idPayClient, idPayment),
    constraint fk_payments_client foreign key(idPayClient) references client(idClient),
    constraint fk_payment_order foreign key(idPayment) references orders(idOrder)
);


-- criando tabela estoque
create table productStorage(
	idProdStorage int auto_increment primary key,
    StorageLocation varchar(255),
    quantity int default 0
);
    
    
-- criando tabela fornecedor
create table supplier(
	idSupplier int auto_increment primary key,
    SocialName varchar(255) not null,
    CNPJ char(15) not null,
    contact char(11) not null,
    constraint unique_supplier unique (CNPJ)
);
desc supplier;
    
-- criando tabela vendedor
	create table seller(
	idSeller int auto_increment primary key,
    SocialName varchar(255) not null,
    CNPJ char(15),
    CPF char(9),
    location varchar (255),
    contact char(11) not null,
    constraint unique_cnpj_seller unique (CNPJ),
    constraint unique_cpf_seller unique (CPF)
);

create table productSeller(
	idPseller int,
    idPproduct int,
    prodQuantity int default 1,
    primary key (idPseller, idPproduct),
    constraint fk_product_seller foreign key (idPseller) references seller(idSeller),
    constraint fk_product_product foreign key (idPproduct) references product(idProduct)
);

desc productSeller;

desc product; 

create table storageLocation(
	idLproduct int,
    idLstorage int,
    Location varchar(255) not null,
    primary key (idLproduct, IdLstorage),
    constraint fk_storage_location_seller foreign key (idLproduct) references product(idProduct),
    constraint fk_storage_location_storage foreign key (IdLstorage) references productStorage(idProdStorage)
);

create table productSupplier(
	idPsSupplier int,
    idPsProduct int,
    quantity int not null,
    primary key (idPsSupplier, idPsProduct),
    constraint fk_product_supplier_supplier foreign key (idPsSupplier) references supplier(idSupplier),
    constraint fk_product_supplier_product foreign key (idPsProduct) references product(idProduct)
);

create table entrega(
idEntrega int,
idPagamento int,
CodigoRastreio int,
primary key (IdEntrega, idPagamento),
constraint fk_entrega_pedido foreign key (idEntrega) references orders(idOrder),
constraint fk_entrega_pagamento foreign key (idPagamento) references payments(idPayment)
);

desc productSupplier;
show tables;
use information_schema;
desc table_constraints;
select * from referential_constraints where constraint_schema = 'ecommerce';