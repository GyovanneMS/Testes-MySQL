



#.  Hello Everybody!!! Boa sorte pra quem vai ler isso, recomendo usar o control + F


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
                
select tables;



DELIMITER $$

create procedure procUpdateEndereco (IN idUsuario int, NewLogradouro varchar(100), NewCEP varchar(15), NewNumero int, NewComplemento varchar(10), Otherid_Bairro int)
Begin 
	DECLARE Endereco int;
    
	set Endereco = (select tbl_Endereco.id
		from tbl_Usuario
			inner join tbl_Endereco
				on tbl_Usuario.id_Endereco = tbl_Endereco.id
			where tbl_Usuario.id = idUsuario);
                
	update tbl_Endereco set
		Logradouro = NewLogradouro,
		CEP = NewCEP,
		Numero = NewNumero,
		Complemento = NewComplemento,
		id_bairro = Otherid_Bairro
	where id = Endereco;

END $$

select * from vwTutorBD;

drop procedure procUpdateEmail;

insert into tbl_Tutor(Nome, CPF, Senha, RG, Foto, id_email, id_endereco) values();

SHOW PROCEDURE STATUS;

call procInsertTutor('Adriana', '123.123.123-12', 'couldWorkPlis@gmail.com', 'def', '88.888.888-8', '2007/06/05', '96666-6666', 77, 1, null);
drop procedure procInsertTutor;
#insert into tbl_Usuario(Nome, CPF, Email, Senha, RG, Genero, DataNascimento, Telefone, DDD, id_Endereco) values();
DELIMITER $$

create procedure procInsertTutor (IN NewNome varchar(90), NewCPF varchar(20), NewEmail varchar(270), NewSenha text, NewRG varchar(15), NewDataNascimento date, 
	NewTelefone varchar(15), NewDDD int, ChooseFormato int, NewFoto text)
BEGIN 
	DECLARE idEndereco int;
	DECLARE idUsuario int;
	DECLARE idTelefone int;	

	set idEndereco = (select id 
    from tbl_Endereco
		order by id 
        desc limit 1);
        
	insert into tbl_Telefone(Numero, DDD, id_Telefone_Formato) values(NewTelefone, NewDDD, ChooseFormato);
    
	set idTelefone = (select id 
    from tbl_Telefone
		order by id 
        desc limit 1);
        
    insert into tbl_Usuario(Nome, CPF, Email, Senha, RG, DataNascimento, id_Telefone, id_Endereco)
					values(NewNome, NewCPF, NewEmail, md5(md5(NewSenha)), NewRG, NewDataNascimento, idTelefone, idEndereco);    
        
	set idUsuario = (select id 
    from tbl_Usuario
		order by id 
        desc limit 1);
	
    insert into tbl_Tutor(Foto_Perfil, id_Usuario) values(NewFoto, idUsuario);
    
END $$



desc tbl_Usuario;
desc tbl_Telefone;
select * from tbl_Telefone_Formato;

DELIMITER $$

create procedure procUpdateTutor (IN idTutor int, ModifierNome varchar(90), ModifierCPF varchar(20), ModifierEmail varchar(270), ModifierSenha text, ModifierRG varchar(15), ModifierDataNascimento date, 
	ModifierTelefone varchar(15), ModifierDDD int, OtherFormato int)
BEGIN 
	DECLARE idTelefone int;
	DECLARE idUsuario int;

	set idUsuario = (select tbl_Usuario.id 
    from tbl_Usuario
    
    inner join tbl_Tutor
		on tbl_Tutor.id_Usuario = tbl_Usuario.id
        
		where tbl_Tutor.id = idTutor);
                    
	update tbl_Usuario set  
		Nome = ModifierNome,
		CPF = ModifierCPF,
		Senha = md5(md5(ModifierSenha)),
		RG = ModifierRG,
		Email = ModifierEmail,
		DataNascimento = ModifierDataNascimento
	where id = 'X';
        
	set idTelefone = (select tbl_Telefone.id 
    from tbl_Telefone
    
    inner join tbl_Usuario
		on tbl_Usuario.id_Endereco = tbl_Telefone.id
        
		where tbl_Usuario.id = idUsuario);
        
	update tbl_Telefone set  
		Numero = ModifierTelefone,
		DDD = ModifierDDD,
		id_Telefone_Formato = OtherFormato
	where id = 'X';
    
END $$

create procedure procInsertTutor (IN idTutor int, NewNome varchar(90), NewCPF varchar(20), NewEmail varchar(270), NewSenha text, NewRG varchar(15), NewDataNascimento date, 
	NewTelefone varchar(15), NewDDD int, OtherFormato int)
BEGIN 
	DECLARE idTelefone int;
	DECLARE idUsuario int;

	set idUsuario = (select tbl_Usuario.id 
    from tbl_Usuario
    
    inner join tbl_Tutor
		on tbl_Tutor.id_Usuario = tbl_Usuario.id
        
		where tbl_Tutor.id = idTutor);
                    
	update tbl_Usuario set  
		Nome = NewNome,
		CPF = NewCPF,
		Senha = md5(md5(NewSenha)),
		RG = NewRG,
		Email = NewEmail,
		DataNascimento = NewDataNascimento
	where id = 'X';
        
	set idTelefone = (select tbl_Telefone.id 
    from tbl_Telefone
    
    inner join tbl_Usuario
		on tbl_Usuario.id_Endereco = tbl_Telefone.id
        
		where tbl_Usuario.id = idUsuario);
        
	update tbl_Telefone set  
		Numero = NewTelefone,
		DDD = NewDDD,
		id_Telefone_Formato = OtherFormato
	where id = 'X';
    
END $$

desc tbl_Telefone;

DELIMITER $$

create procedure procInsertVeterinario (IN NewNome varchar(90), NewCPF varchar(20), NewEmail varchar(270), NewSenha text, NewRG varchar(15), NewDataNascimento date, 
	NewTelefone varchar(15), NewDDD int, NewBiografia text, NewCRMVNumero int, IdEstado int, idInstituicao int, AnoFormacao year)
BEGIN 
	DECLARE idEndereco int;
	DECLARE idUsuario int;
    DECLARE idCRMV int;
    DECLARE idFormacao int;

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
        
	insert into tbl_CRMV(Numero, id_Estado) values(NewCRMVNumero, IdEstado);
    
	insert into tbl_Formacao(Ano, id_Instituicao) values(AnoFormacao, idInstituicao);
        
	set idCRMV = (select id 
    from tbl_CRMV
		order by id 
        desc limit 1);
        
	set idFormacao = (select id 
    from tbl_Formacao
		order by id 
        desc limit 1);
	
    insert into tbl_Veterinario(Biografia, Avaliacao, id_CRMV, id_Formacao, id_Usuario) values(NewFoto, idUsuario, idCRMV, idFormacao, idUsuario);
    
END $$

create view vwPet as 
select tbl_Pet.id, tbl_Pet.nome as Nome, tbl_Pet.DataNascimento, tbl_Pet.Foto, 
		 tbl_Nivel_de_agrecividade.Nome as Nivel_Agressividade,
         tbl_Sexo.Nome as Sexo,
         tbl_Microship.Resposta as Microship,
         tbl_Tamanho.Nome as Tamanho,
         tbl_Especie.Nome as Especie, tbl_Raca.Nome as Raca
         tbl_Cor.Cor, tbl_Nivel.numero,
         tbl_Nivel_Agressividade.nome as formato
         
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
				on tbl_Telefone.id_telefone_formato = tbl_Telefone_formato.id
			inner join tbl_Pet_Cor;

desc tbl_Pet_Cor;

create table tbl_Veterinario(
	id int not null auto_increment primary key,  	
	Biografia text,
    Avaliacao int,
    
	id_CRMV int not null,
    constraint  fk_CRMV_veterinario
		foreign key(id_CRMV)
		references tbl_CRMV(id),
        
	id_Formacao int not null,
    constraint  fk_Formacao_veterinario
		foreign key(id_Formacao)
		references tbl_Formacao(id),
        
	id_Usuario int not null,
    constraint  fk_usuario_veterinario
		foreign key(id_Usuario)
		references tbl_Usuario(id),
    
    unique index(id)	
);



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
			
            
create view vwAllTutor as 
select tbl_tutor.id, tbl_tutor.Foto_Perfil, 
		 tbl_Usuario.Nome, tbl_Usuario.CPF, tbl_Usuario.RG, tbl_Usuario.DataNascimento, tbl_Usuario.email,
         tbl_Endereco.Logradouro, tbl_Endereco.CEP, tbl_Endereco.Numero as Numero_Endereco, tbl_Endereco.Complemento,
         tbl_Bairro.Nome as Bairro,
         tbl_Cidade.Nome as Cidade,
         tbl_Estado.Nome as Estado, tbl_Estado.Sigla,
         tbl_Telefone.DDD, tbl_Telefone.Numero as Numero_Telefone,
         tbl_Telefone_formato.nome as formato
         
         from tbl_tutor
			inner join tbl_Usuario
				on tbl_Tutor.id_Usuario = tbl_Usuario.id
			inner join tbl_Endereco
				on tbl_Usuario.id_Endereco = tbl_Endereco.id
			inner join tbl_Bairro
				on tbl_Endereco.id_Bairro = tbl_Bairro.id
			inner join tbl_Cidade
				on tbl_Bairro.id_Cidade = tbl_Cidade.id
			inner join tbl_Estado
				on tbl_Cidade.id_Estado = tbl_Estado.id
			inner join tbl_Telefone
				on tbl_Usuario.id_Telefone = tbl_Telefone.id
			inner join tbl_Telefone_formato
				on tbl_Telefone.id_telefone_formato = tbl_Telefone_formato.id;
                
desc tbl_Usuario;
	
                
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