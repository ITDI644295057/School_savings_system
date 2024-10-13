<?php
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept');
header("Content-type:application/json",true);
header('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, OPTIONS');

$app->group('/api', function () use ($app) {
    
    //login ผู้ปกครอง
    $app->post('/user', function ($request, $response) {
        $input = $request->getParsedBody();
        $sql = "SELECT * FROM parents WHERE username=:username AND password=:password";
        $sth = $this->db->prepare($sql);
        $sth->bindParam("username", $input['username']);
        $sth->bindParam("password", $input['password']);
        $sth->execute();
        $count = $sth->rowCount();
        if($count==0){
            $message = (object)array('username' => 'failed', 'password' => 'failed'); 
            return $this->response->withJson($message);
        }else{
            $user = $sth->fetchObject();
            return $this->response->withJson($user);          
        }
    });

    //login คุณครู
    $app->post('/teacher', function ($request, $response) {
        $input = $request->getParsedBody();
        $sql = "SELECT * FROM teacher WHERE username=:username AND password=:password";
        $sth = $this->db->prepare($sql);
        $sth->bindParam("username", $input['username']);
        $sth->bindParam("password", $input['password']);
        $sth->execute();
        $count = $sth->rowCount();
        if($count==0){
            $message = (object)array('username' => 'failed', 'password' => 'failed'); 
            return $this->response->withJson($message);
        }else{
            $user = $sth->fetchObject();
            return $this->response->withJson($user);          
        }
    });

    //ดึงข้อมูลนักเรียน ที่มีความสัมพันธ์กับผู้ปกครอง
    $app->get('/user', function ($request, $response) {
        $input = $request->getParsedBody();
        $sql = "SELECT  g.parent_id,s.student_id AS student_id , s.name AS student_name, s.surname AS student_surname,s.account AS account_number
               FROM guardianship g
               JOIN student s ON g.student_id =  s.student_id;";
        $sth = $this->db->prepare($sql);
        $sth->execute();
        $count = $sth->rowCount();
        if($count==0){
            return $this->response->withJson($message);
        }else{
            $user = $sth->fetchAll();
            return $this->response->withJson($user);          
        }
    });   

    //ดึงข้อมูล กระเป๋าเงินที่เชื่อมกับนักเรียน
    $app->get('/wallet', function ($request, $response) {
        $sql = "SELECT s.account, w.amount
                FROM wallet w
                JOIN student s ON s.account = w.account";
        $sth = $this->db->prepare($sql);
        $sth->execute();
        $data = $sth->fetchAll();
        // Check if there is any data
        if (count($data) === 0) {
            // If no data found, return a JSON response with an empty array
            return $this->response->withJson([]);
        } else {
            // Return the fetched data as JSON response
            return $this->response->withJson($data);
        }
    });

    //ดึงข้อมูลมาแสดงในสลิปการฝากเงินของผู้ปกครองในระบบ
    $app->get('/slip', function ($request, $response) {
        // Prepare the SQL query to fetch the required information
        $sql = "SELECT 
                    s.name AS s_name,
                    s.surname AS s_surname ,
                    c.class_id,
                    c.class_level ,
                    s.student_id,
                    p.name AS p_name ,
                    p.surname AS p_surname,
                    w.account 
                FROM student s
                JOIN guardianship g ON s.student_id = g.student_id
                JOIN parents p ON g.parent_id = p.parent_id
                JOIN wallet w ON s.account = w.account
                JOIN class c ON s.class_id = c.class_id";
        
        // Prepare and execute the query
        $sth = $this->db->prepare($sql);
        $sth->execute();
        
        // Fetch all results
        $data = $sth->fetchAll();
        
        // Check if there is any data
        if (count($data) === 0) {
            // If no data found, return a JSON response with an empty array
            return $this->response->withJson([]);
        } else {
            // Return the fetched data as JSON response
            return $this->response->withJson($data);
        }
    });

    //ดึงข้อมูลมาแสดงในสลิปการฝาก(เงินสด)ถอน และยืม
    $app->get('/slipw', function ($request, $response) {
        // Prepare the SQL query to fetch the required information
        $sql = "SELECT 
                    s.name AS s_name,
                    s.surname AS s_surname ,
                    c.class_id,
                    c.class_level ,
                    s.student_id,
                    t.name AS t_name ,
                    t.surname AS t_surname,
                    w.account 
                FROM student s
                JOIN teacher t ON t.class_id= s.class_id
                JOIN wallet w ON s.account = w.account
                JOIN class c ON s.class_id = c.class_id";
        
        // Prepare and execute the query
        $sth = $this->db->prepare($sql);
        $sth->execute();
        
        // Fetch all results
        $data = $sth->fetchAll();
        
        // Check if there is any data
        if (count($data) === 0) {
            // If no data found, return a JSON response with an empty array
            return $this->response->withJson([]);
        } else {
            // Return the fetched data as JSON response
            return $this->response->withJson($data);
        }
    });


    //ดึงข้อมูลนักเรียนที่สัมพันธ์กับห้องเรียน และ กระเป๋าเงิน 
    $app->get('/student', function ($request, $response) {
        $input = $request->getParsedBody();
        $sql = "SELECT  s.student_id,s.name AS student_name,s.surname AS student_surname,c.class_id,c.class_level,
                w.account , w.amount FROM student s 
                JOIN class c ON s.class_id = c.class_id
                JOIN wallet w ON s.account = w.account ;";
        $sth = $this->db->prepare($sql);
        $sth->execute();
        $count = $sth->rowCount();
        if($count==0){
            return $this->response->withJson($message);
        }else{
            $user = $sth->fetchAll();
            return $this->response->withJson($user);          
        }
    });   

    //อัปเดตกระเป๋าเงินเมื่อมีการฝาก-ถอน-ยืมเงิน
    $app->post('/wallet/[{account}]', function ($request, $response, $args) {
        $input = $request->getParsedBody();
        $type = $input['type']; // 'deposit' or 'withdrawal'
        $amount = $input['amount'];

        if ($type == 'deposit' ) {
            $sql = "UPDATE wallet SET amount = amount + :amount WHERE account = :account";
        } elseif ($type == 'withdrawal') {
            $sql = "UPDATE wallet SET amount = amount - :amount WHERE account = :account";
        } elseif ($type == 'borrow') {
            $sql = "UPDATE wallet SET amount = amount + :amount WHERE account = :account";
        }else{
            return $this->response->withJson(['error' => 'Invalid transaction type'], 400);
        }

        $sth = $this->db->prepare($sql);
        $sth->bindParam("account", $args['account']);
        $sth->bindParam("amount", $amount);
            
        try {
            $sth->execute();
            $count = $sth->rowCount();
            return $this->response->withJson($count);
        } catch (PDOException $e) {
            return $this->response->withJson(0);
        }
    });

    //เพิ่มข้อมูลการฝากเงินจากผู้ปกครอง ในตาราง transaction ที่มีการอนุมัติจากครูภายหลัง
    $app->post('/transaction/deposit', function ($request, $response) {
        $input = $request->getParsedBody();
                
        //--- insert data to db
        $sql = "INSERT INTO `transaction` (`tran_id`, `account`, `transaction_type`, `status`, `approver`, `money`, `date`, `time`, `imagepath`) VALUES (NULL, :account, :transaction_type, NULL, NULL, :money, CURDATE(), CURTIME(), :imagepath)";
                
        $sth = $this->db->prepare($sql);
        $sth->bindParam("account", $input['account']);
        $sth->bindParam("transaction_type", $input['transaction_type']);
        $sth->bindParam("money", $input['money']);
        $sth->bindParam("imagepath",$input['imagepath']);
        try{
            $sth->execute();
            $count = $sth->rowCount();
            return $this->response->withJson($count);
        }catch(PDOException $e){
            //echo($e);
            return $this->response->withJson(0);
        }
    });  

    //เพิ่มข้อมูลการฝาก(เงินสด) ถอน ยืม ที่มีการอนุมัติแล้ว โดยมีครูเป็นผู้ทำรายการ
    $app->post('/transaction', function ($request, $response) {
        $input = $request->getParsedBody();

        $sql = "INSERT INTO `transaction` (`tran_id`, `account`, `transaction_type`, `status`, `approver`, `money`, `date`, `time`, `imagepath`) VALUES (NULL, :account, :transaction_type, :status, :approver, :money, CURDATE(), CURTIME(), :imagepath)";
                
        $sth = $this->db->prepare($sql);
        $sth->bindParam("account", $input['account']);
        $sth->bindParam("transaction_type", $input['transaction_type']);
        $sth->bindParam("status", $input['status']);      
        $sth->bindParam("approver", $input['approver']);  
        $sth->bindParam("money", $input['money']);
        $sth->bindParam("imagepath", $input['imagepath']);
        
        try {
            $sth->execute();
            $count = $sth->rowCount();
            return $this->response->withJson($count);
        } catch(PDOException $e) {
            //echo($e);
            return $this->response->withJson(0);
        }
    });
    
    //เรียกดูตาราง transaction ดูรายการธุรกรรมต่างๆ
    $app->get('/transaction', function ($request, $response) {
        $input = $request->getParsedBody();
        $sql = "SELECT  * FROM transaction;";
        $sth = $this->db->prepare($sql);
        $sth->execute();
        $count = $sth->rowCount();
        if($count==0){
            return $this->response->withJson($message);
        }else{
            $user = $sth->fetchAll();
            return $this->response->withJson($user);          
        }
    });  
    
    //อัปเดตตาราง transaction เมื่อครูมาอนุมัติการฝากเงิน
    $app->post('/transaction/[{tran_id}]', function ($request, $response, $args) {
        $input = $request->getParsedBody();
               
        //--- insert data to db
        $sql = "UPDATE transaction SET status = :status, approver = :approver WHERE tran_id = :tran_id;";
                
        $sth = $this->db->prepare($sql);
        $sth->bindParam("tran_id", $args['tran_id']);
        $sth->bindParam("status", $input['status']);
        $sth->bindParam("approver", $input['approver']);
        try{
            $sth->execute();
            $count = $sth->rowCount();
            return $this->response->withJson($count);
        }catch(PDOException $e){
            //echo($e);
            return $this->response->withJson(0);
        }
    });  

    //ดึงข้อมูลผู้ปกครอง 
    $app->get('/parent', function ($request, $response) {
        $input = $request->getParsedBody();
        $sql = "SELECT  * FROM parents;";
        $sth = $this->db->prepare($sql);
        $sth->execute();
        $count = $sth->rowCount();
        if($count==0){
            return $this->response->withJson($message);
        }else{
            $user = $sth->fetchAll();
            return $this->response->withJson($user);          
        }
    });   

    //อัปเดต username และ password ผู้ปกครอง
    $app->post('/parent/[{parent_id}]', function ($request, $response, $args) {
        $input = $request->getParsedBody();
               
        //--- insert data to db
        $sql = "UPDATE parents SET username = :username, password = :password WHERE parent_id = :parent_id;";
                
        $sth = $this->db->prepare($sql);
        $sth->bindParam("parent_id", $args['parent_id']);
        $sth->bindParam("username", $input['username']);
        $sth->bindParam("password", $input['password']);
        try{
            $sth->execute();
            $count = $sth->rowCount();
            return $this->response->withJson($count);
        }catch(PDOException $e){
            //echo($e);
            return $this->response->withJson(0);
        }
    });  

    //ดึงข้อมูลครู
    $app->get('/teachers', function ($request, $response) {
        $input = $request->getParsedBody();
        $sql = "SELECT  * FROM teacher;";
        $sth = $this->db->prepare($sql);
        $sth->execute();
        $count = $sth->rowCount();
        if($count==0){
            return $this->response->withJson($message);
        }else{
            $user = $sth->fetchAll();
            return $this->response->withJson($user);          
        }
    });   

    //อัปเดต username และ password ครู
    $app->post('/teachers/[{teacher_id}]', function ($request, $response, $args) {
        $input = $request->getParsedBody();
               
        //--- insert data to db
        $sql = "UPDATE teacher SET username = :username, password = :password WHERE teacher_id = :teacher_id;";
                
        $sth = $this->db->prepare($sql);
        $sth->bindParam("teacher_id", $args['teacher_id']);
        $sth->bindParam("username", $input['username']);
        $sth->bindParam("password", $input['password']);
        try{
            $sth->execute();
            $count = $sth->rowCount();
            return $this->response->withJson($count);
        }catch(PDOException $e){
            //echo($e);
            return $this->response->withJson(0);
        }
    });  
});
