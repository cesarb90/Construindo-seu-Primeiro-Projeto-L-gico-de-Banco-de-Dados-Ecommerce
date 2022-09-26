# Construindo-seu-Primeiro-Projeto-L-gico-de-Banco-de-Dados-Ecommerce
Construindo seu Primeiro Projeto Lógico de Banco de Dados

Perguntas
Quais os nomes dos clientes e seus respectivos endereços?
select concat(Fname,' ',Lname)as Complete_Name, Address from client;


Quantos produtos foram vendidos?
select Pname, idPOproduct, count(*) as Quantidade
from product, productOrder, orders
where idPOproduct = idOrder
group by PoQuantity
having count(*) >2
order by Pname;