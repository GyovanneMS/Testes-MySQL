use db_TCC_PetSaude;

show databases;

select * from tbl_Telefone_formato;



drop trigger Tgr_TutorInserts;


insert into tbl_email(Email) values();


insert into tbl_Estado(Nome, Sigla) values();


insert into tbl_Cidade(Nome, id_estado) values();


insert into tbl_Bairro(Nome, id_cidade) values();


insert into tbl_Endereco(Logradouro, CEP, Numero, Complemento, id_bairro) values();


#insert into tbl_Telefone_formato(Nome) values('Celular'), ('Residencial'), ('Comercial');


Insert into tbl_Telefone(DDD, Numero, id_telefone_formato) values(25, '4998-6784', 2);


insert into tbl_Tutor(Nome, CPF, Senha, RG, Foto, id_email, id_endereco) 
			values();

use db_TCC_PetSaude;
select * from tbl_Tutor;
select * from tbl_Tutor_Telefone;
select * from tbl_Telefone;
select * from tbl_Telefone_formato;
desc tbl_Telefone;

select * from tbl_Tutor;
insert into tbl_Tutor_Telefone(id_tutor, id_telefone) values(10,1);
insert into tbl_Tutor_Telefone(id_tutor, id_telefone) values(16,2);

select tbl_tutor.id, tbl_tutor.nome as Nome, tbl_tutor.CPF, tbl_tutor.RG, tbl_tutor.Foto, 
		 tbl_email.email,
         tbl_Endereco.Logradouro, tbl_Endereco.CEP, tbl_Endereco.Numero, tbl_Endereco.Complemento,
         tbl_Bairro.Nome as Bairro,
         tbl_Cidade.Nome as Cidade,
         tbl_Estado.Nome as Estado, tbl_Estado.Sigla
         #tbl_Telefone.DDD, tbl_Telefone.numero,
        # tbl_Telefone_formato.nome as formato
         
         from tbl_tutor
			inner join tbl_Email
				on tbl_Tutor.id_email = tbl_Email.id
			inner join tbl_Endereco
				on tbl_Tutor.id_Endereco = tbl_Endereco.id
			inner join tbl_Bairro
				on tbl_Endereco.id_Bairro = tbl_Bairro.id
			inner join tbl_Cidade
				on tbl_Bairro.id_Cidade = tbl_Cidade.id
			inner join tbl_Estado
				on tbl_Cidade.id_Estado = tbl_Estado.id
            left join tbl_Tutor_Telefone    
				on tbl_Tutor_Telefone.id_Tutor = tbl_tutor.id
			inner join tbl_Telefone 
				on tbl_Tutor_Telefone.id_Telefone = tbl_Telefone.id
			inner join tbl_Telefone_Formato
				on tbl_Telefone.id_telefone_formato = tbl_Telefone_formato.id;
                
create view vwTutor as 
select tbl_tutor.id, tbl_tutor.nome as Nome, tbl_tutor.CPF, tbl_tutor.RG, tbl_tutor.Foto, 
		 tbl_email.email,
         tbl_Endereco.Logradouro, tbl_Endereco.CEP, tbl_Endereco.Numero, tbl_Endereco.Complemento,
         tbl_Bairro.Nome as Bairro,
         tbl_Cidade.Nome as Cidade,
         tbl_Estado.Nome as Estado, tbl_Estado.Sigla
         #tbl_Telefone.DDD, tbl_Telefone.numero,
        # tbl_Telefone_formato.nome as formato
         
         from tbl_tutor
			inner join tbl_Email
				on tbl_Tutor.id_email = tbl_Email.id
			inner join tbl_Endereco
				on tbl_Tutor.id_Endereco = tbl_Endereco.id
			inner join tbl_Bairro
				on tbl_Endereco.id_Bairro = tbl_Bairro.id
			inner join tbl_Cidade
				on tbl_Bairro.id_Cidade = tbl_Cidade.id
			inner join tbl_Estado
				on tbl_Cidade.id_Estado = tbl_Estado.id
            left join tbl_Tutor_Telefone    
				on tbl_Tutor_Telefone.id_Tutor = tbl_tutor.id
			inner join tbl_Telefone 
				on tbl_Tutor_Telefone.id_Telefone = tbl_Telefone.id
			inner join tbl_Telefone_Formato
				on tbl_Telefone.id_telefone_formato = tbl_Telefone_formato.id;
                
show tables;

DELIMITER $$

create procedure procUpdateEndereco (IN idTutor int, NewLogradouro varchar(100), NewCEP varchar(15), NewNumero int, NewComplemento varchar(10), Newid_Bairro int)
Begin 
	DECLARE Endereco int;
    
	set Endereco = (select tbl_Endereco.id
		from tbl_Tutor
			inner join tbl_Endereco
				on tbl_Tutor.id_Endereco = tbl_Endereco.id
			where tbl_Tutor.id = idTutor);
                
	update tbl_Endereco set
		Logradouro = NewLogradouro,
		CEP = NewCEP,
		Numero = NewNumero,
		Complemento = NewComplemento,
		id_bairro = Newid_Bairro
	where id = Endereco;

END $$


DELIMITER $$

create procedure procUpdateEmail (IN idTutor int, NewEmail varchar(270))
Begin 
	DECLARE Email int;
    
	set Email = (select tbl_Email.id
		from tbl_Tutor
			inner join tbl_Email
				on tbl_Tutor.id_Endereco = tbl_Email.id
			where tbl_Tutor.id = idTutor);
                
	update tbl_Email set
		Email = NewEmail
	where id = Email;

END $$

call procUpdateEmail(10, 'JaAcabouJessica?@gmail.com');

select * from vwTutorBD;

drop procedure procUpdateEmail;

insert into tbl_Tutor(Nome, CPF, Senha, RG, Foto, id_email, id_endereco) values();

SHOW PROCEDURE STATUS;



#insert into tbl_Usuario(Nome, CPF, Email, Senha, RG, Genero, DataNascimento, Telefone, DDD, id_Endereco) values();
DELIMITER $$

create procedure procInsertTutor (IN NewNome varchar(90), NewCPF varchar(20), NewEmail varchar(270), NewSenha text, NewRG varchar(15), NewDataNascimento date, 
	NewTelefone varchar(15), NewDDD int, NewFoto text)
BEGIN 
	DECLARE idEndereco int;
	DECLARE idUsuario int;

	set idEndereco = (select id 
    from tbl_Endereco
		order by id 
        desc limit 1);
        
    insert into tbl_Usuario(Nome, CPF, Email, Senha, RG, DataNascimento, Telefone, DDD, id_Endereco)
					values(NewNome, NewCPF, NewEmail, md5(md5(NewSenha)), NewRG, NewDataNascimento, NewTelefone, NewDDD, idEndereco);    
        
	set idUsuario = (select id 
    from tbl_Usuario
		order by id 
        desc limit 1);
	
    insert into tbl_Tutor(Foto, id_Usuario) values(NewFoto, idUsuario);
    
END $$

drop procedure procInsertTutor;

call procedure procInsertTutor()

select * from tbl_Endereco;
insert into tbl_Endereco(Logradouro, CEP, Numero, Complemento, id_bairro) values('ABC', '00011-222', 444, 'N/A', 2);

 insert into tbl_Tutor(Nome, CPF, Senha, RG, Foto, id_email, id_endereco)
 select 'Nome', 'CPF', md5(md5('Senha')), 'RG', 'Foto', 
 tbl_Email.id, 
 tbl_Endereco.id 
	from tbl_Endereco, tbl_Email
		order by tbl_Endereco.id and tbl_Email.id desc limit 1;

call procInsertTutor('Seu zé', '405.605.305-20', 'abc', '12.456.456-4', null);

select * from vwTutorBD;


select * from tbl_Endereco;

show procedure status;
			
            
create view vwTutorBD as 
select tbl_tutor.id, tbl_tutor.nome as Nome, tbl_tutor.CPF, tbl_tutor.RG, tbl_tutor.Foto, 
		 tbl_email.email,
         tbl_Endereco.Logradouro, tbl_Endereco.CEP, tbl_Endereco.Numero, tbl_Endereco.Complemento,
         tbl_Bairro.Nome as Bairro,
         tbl_Cidade.Nome as Cidade,
         tbl_Estado.Nome as Estado, tbl_Estado.Sigla
         #tbl_Telefone.DDD, tbl_Telefone.numero,
        # tbl_Telefone_formato.nome as formato
         
         from tbl_tutor
			inner join tbl_Email
				on tbl_Tutor.id_email = tbl_Email.id
			inner join tbl_Endereco
				on tbl_Tutor.id_Endereco = tbl_Endereco.id
			inner join tbl_Bairro
				on tbl_Endereco.id_Bairro = tbl_Bairro.id
			inner join tbl_Cidade
				on tbl_Bairro.id_Cidade = tbl_Cidade.id
			inner join tbl_Estado
				on tbl_Cidade.id_Estado = tbl_Estado.id
                
                
delete from tbl_Tutor where id = 18;

select * from tbl_Tutor;
                
drop trigger tgrDeleteInformationsTutores;
                
DELIMITER $$

create trigger tgrDeleteInformationsTutores
	after delete on tbl_Tutor
		for each row
			BEGIN
				delete from tbl_Endereco where id = OLD.Id_Endereco;
				delete from tbl_Email where id = OLD.Id_Email;
END $$

select * from tbl_Tutor;

delete from tbl_Tutor where id = 18;
call procDeleteTutor(17);

desc tbl_Endereco;

drop procedure procDeleteTutor;

DELIMITER $$

create procedure procDeleteTutor (IN idTutor int)
BEGIN 

	DECLARE idEndereco int;
	DECLARE idEmail int;
    
    set idEndereco = (select tbl_Endereco.id 
							from tbl_Endereco
								inner join tbl_Tutor
									on tbl_Tutor.id_Endereco = tbl_Endereco.id 
							 where tbl_Tutor.id = idTutor);  
    
    set idEmail = (select tbl_Email.id 
							from tbl_Email
								inner join tbl_Tutor
									on tbl_Tutor.id_Email = tbl_Email.id 
							 where tbl_Tutor.id = idTutor);
                             
	delete from tbl_Tutor where id = idTutor;
	delete from tbl_Endereco where id = idEndereco;
	delete from tbl_Email where id = idEmail;
                

      
		
END $$