var mysql = require('mysql');
var app = require('express');
var exp=app();
var url=require('url');
//var express = require('express');

var connection = mysql.createConnection({
  host     : 'localhost',
  user     : 'root',
  password : 'root',
  database : 'gotocollege'
});

// connection.connect();

exp.get('/userlogin', function(req, res){

	var user={
		nam:req.query.user,
		email:req.query.email,
		income:req.query.income,
		savings:req.query.savings
	};
  // console.log("name "+user.nam);
  // console.log("email "+user.email);
  // console.log("income "+user.income);
  // console.log("savings "+user.savings);

  	var rows;
	connection.query('SELECT uid from gotocollege.userprofile WHERE email=?',user.email, function(err, rows, fields) {
		if (!err) {
			console.log('The solution is: ', rows);
		}
		else
		{
			console.log("rows"+err);
			console.log('Error while performing Query.');
		}
	});
	
	if(rows==null)
	{
		var post={
				uid:null,
				name:user.nam,
				email:user.email,
				income:user.income,
				savings:user.savings
		};

		console.log("name "+post.name);
		console.log("email "+post.email);
		console.log("income "+post.income);
		console.log("savings "+post.savings);	
	
		connection.query('INSERT INTO gotocollege.userprofile SET?',post,function(err, rows, fields) {
			if (!err) {
				console.log('The solution is: ', rows);
				var json = JSON.stringify({
					title: 'success',
					message: 'Added Entry',
				});
				res.status(200).send(json);
			}
			else
			{
				console.log("here"+err);
				console.log('Error while performing Query.');
				var json = JSON.stringify({
					title: 'error',
					message: 'Insertion Failed',
				});
				res.status(500).send(json);
			}
		});	
	} else {
		var json = JSON.stringify({
			title: 'error',
			message: 'Duplicate Entry'
		});
		res.status(500).send(json);
	}
});


//univ details

exp.get('/univdetails',function(req,res){
	var user=res.body;
		
	connection.query('SELECT univ_name,tution_fees,living_expenses from gotocollege.university_details', function(err, rows, fields) {
		if (!err)
		{
		  console.log('The solution is: ', rows);
		  res.send(rows);
		}
		else {
		  console.log("rows"+err);
		  console.log('Error while performing Query.');
		}
	});
});


/*for calculator*/
exp.get('/calculator',function(req,res){
	var calc=res.body;
	var calc={
		affordable_tution: req.query.affordable_tution,
		email:req.query.email,
		major:req.query.major,
		no_of_years:req.query.no_of_years
	};
	var affordable_tution=calc.affordable_tution;
	var email=calc.email;
	var major=calc.major;
	var no_of_years=calc.no_of_years;
	connection.query('SELECT univ_name,tution_fees,living_expenses from gotocollege.university_details WHERE living_expenses+tution_fees <=?',affordable_tution,function(err, rows, fields) {
		var  clgs=[];
		if (!err)
		 {
		 	console.log('The solution is: ', rows);
		 	// var json = JSON.stringify({
		 	// 	description: rows;
		 	// });
		 	// for(var r in rows)
		 	// {
		 	// 	clgs.push({"univ_name":r.univ_name,"tution_fees":r.tution_fees,"living_expenses":r.living_expenses});
		 	// }	
		 	// console.log(clgs);
		 	// res.send(clgs);
		 	res.send(rows);
		 } 
		else
		{
		  console.log("rows"+err);
		  console.log('Error while performing Query.');
		}
	});
	
//			major,yrs,email
});

// connection.end();
exp.listen(3000);

//var app = express.createServer();

//var http = require('http').Server(exp);
//var http = require('http');
//var body_parser = require("body-parser");



//app.use(express.staticProvider(__dirname + '/public'));
//var server = http.createServer(function (request, response) {
  //app.get('/', function(req, res) {

    //res.render('index.html');



// spin up server




	//response.writeHead(200,{"Content-Type":"text/plain"});
  //response.end("Hfhfhdgdgdgd\n");
    //exp.get('/userlogin',function(req,res){
	/*var user=response.body;
	

	var url_parts=url.parse(request.url,true);
	var query=url_parts.query;
	console.log("response"+request.url);

	/*var user={
			uid:null,
			name:'tanvi',
			email:'tanvi@234',
			income:1098.5,
			savings:234.5
	};
	var rows;
	connection.query('SELECT uid from gotocollege.userprofile WHERE email=?',user.email, function(err, rows, fields) {
		if (!err)
			console.log('The solution is: ', rows);
		else
		{
			console.log("rows"+err);
			console.log('Error while performing Query.');
		}
	});
	
	if(rows==null)
	{
		var post={
				uid:null,
				name:user.name,
				email:user.email,
				income:user.income,
				savings:user.savings
				
		};
	
	
	connection.query('INSERT INTO gotocollege.userprofile SET?',post,function(err, rows, fields) {
		if (!err)
			console.log('The solution is: ', rows);
		else
		{
			console.log("rows"+err);
			console.log('Error while performing Query.');
		}
	});	

	//}
}
/*

connection.query('SELECT uid from gotocollege.userprofile WHERE ', function(err, rows, fields) {
  if (!err)
    console.log('The solution is: ', rows);
  else
	  {
	  console.log("rows"+err);
    console.log('Error while performing Query.');
	  }
});

	//exp.get('/univdetails',function(req,res){
	//var user=res.body;
		
		connection.query('SELECT univ_name,tution_fees,living_expenses from gotocollege.university_details', function(err, rows, fields) {
		if (!err)
		  console.log('The solution is: ', rows);
		else
		 {
		  console.log("rows"+err);
		  console.log('Error while performing Query.');
		 }
		});
	//}*/
	
	 /*for calculator*/
		
		//exp.get('/calculator',function(req,res){
			//var calc=res.body;
		/*	var calc={
				affordable_tution:100000,
				email:'abc@Wwew',
				major:'CS',
				no_of_years:2
			};
			var affordable_tution=calc.affordable_tution;
			var email=calc.email;
			var major=calc.major;
			var no_of_years=calc.no_of_years;
			
			connection.query('SELECT univ_name,tution_fees,living_expenses from gotocollege.university_details WHERE living_expenses+tution_fees <=?',affordable_tution,function(err, rows, fields) {
				if (!err)
				  console.log('The solution is: ', rows);
				else
				 {
				  console.log("rows"+err);
				  console.log('Error while performing Query.');
				 }
				});
			
//			major,yrs,email
	//	}*/




//});
//server.listen(8080, '127.0.0.1')



	