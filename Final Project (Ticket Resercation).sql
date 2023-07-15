SELECT * FROM Pemesan
SELECT * FROM Kereta
SELECT * FROM Menu_Makanan
SELECT * FROM Transaksi_Pemesanan
SELECT * FROM Feedback
SELECT * FROM Transaksidetail_Penumpang
SELECT * FROM Tempat_duduk
SELECT * FROM Transaksi_makanan
SELECT * FROM Transaksimakanan_detail

----------------------------------------- SEQUENCES -----------------------------------------
-- Sequence: Pemesan_seq
CREATE SEQUENCE Pemesan_seq
      INCREMENT BY 1
      NO MINVALUE
      NO MAXVALUE
      START WITH 1001
      NO CYCLE;

-- Sequence: Kereta_seq
CREATE SEQUENCE Kereta_seq
      INCREMENT BY 1
      NO MINVALUE
      NO MAXVALUE
      START WITH 2001
      NO CYCLE;

-- Sequence: Menu Makanan_seq
CREATE SEQUENCE Menu_Makanan_seq
      INCREMENT BY 1
      NO MINVALUE
      NO MAXVALUE
      START WITH 3001
      NO CYCLE;
	  
-- Sequence: Transaksi_Pemesanan_seq
CREATE SEQUENCE Transaksi_Pemesanan_seq
      INCREMENT BY 1
      NO MINVALUE
      NO MAXVALUE
      START WITH 4001
      NO CYCLE;

-- Sequence: Feedback_seq
CREATE SEQUENCE Feedback_seq
      INCREMENT BY 1
      NO MINVALUE
      NO MAXVALUE
      START WITH 5001
      NO CYCLE;

-- Sequence: TransaksiDetail_Penumpang_seq
CREATE SEQUENCE TransaksiDetail_Penumpang_seq
      INCREMENT BY 1
      NO MINVALUE
      NO MAXVALUE
      START WITH 6001
      NO CYCLE;

-- Sequence: tempat_duduk_seq
CREATE SEQUENCE Tempat_Duduk_seq
      INCREMENT BY 1
      NO MINVALUE
      NO MAXVALUE
      START WITH 7001
      NO CYCLE;

-- Sequence: Transaksi_Makanan_seq
CREATE SEQUENCE Transaksi_Makanan_seq
      INCREMENT BY 1
      NO MINVALUE
      NO MAXVALUE
      START WITH 8001
      NO CYCLE;

----------------------------------------- CREATE TABLE -----------------------------------------
-- Table: Pemesan
CREATE TABLE Pemesan (
    ID_Pemesan int DEFAULT nextval('pemesan_seq') NOT NULL,
    Nama_Pemesan varchar(256)  NOT NULL,
    no_HP varchar(12)  NOT NULL,
    CONSTRAINT Pemesan_pk PRIMARY KEY (ID_Pemesan)
);

-- Table: Kereta
CREATE TABLE Kereta (
    ID_Kereta int DEFAULT nextval('kereta_seq') NOT NULL,
    Nama_Kereta varchar(256)  NOT NULL,
    Asal varchar(256)  NOT NULL,
    Tujuan varchar(256)  NOT NULL,
    Jam_Berangkat time  NOT NULL,
    Jam_Tiba time  NOT NULL,
    harga int  NOT NULL,
    Tanggal_Pemberangkatan date  NOT NULL,
    CONSTRAINT Kereta_pk PRIMARY KEY (ID_Kereta )
);

-- Table: Menu_Makanan
CREATE TABLE Menu_Makanan (
    ID_Menu int DEFAULT nextval('menu_makanan_seq') NOT NULL,
    Nama_Menu varchar(256)  NOT NULL,
    Harga_Menu int  NOT NULL,
    CONSTRAINT Menu_Makanan_pk PRIMARY KEY (ID_Menu)
);

-- Table: Transaksi_Pemesanan
CREATE TABLE Transaksi_Pemesanan (
    ID_TransaksiPemesanan int DEFAULT nextval('transaksi_pemesanan_seq') NOT NULL,
    Tanggal_Pemesanan date  NOT NULL,
    Jumlah int  NOT NULL,
    ID_Pemesan int  NOT NULL,
    ID_Kereta  int  NOT NULL,
    CONSTRAINT Transaksi_Pemesanan_pk PRIMARY KEY (ID_TransaksiPemesanan)
);

-- Table: Feedback
CREATE TABLE Feedback (
    ID_Feedback int DEFAULT nextval('feedback_seq') NOT NULL,
    Isi_Feedback varchar(1000)  NOT NULL,
    ID_TransaksiPemesanan int  NOT NULL,
    CONSTRAINT Feedback_pk PRIMARY KEY (ID_Feedback)
);

-- Table: TransaksiDetail_Penumpang
CREATE TABLE TransaksiDetail_Penumpang (
    ID_DetailPenumpang int DEFAULT nextval('transaksidetail_penumpang_seq') NOT NULL,
    Nama_Penumpang varchar(256)  NOT NULL,
    No_Hp varchar(12)  NOT NULL,
    ID_TransaksiPemesanan int  NOT NULL,
	ID_TempatDuduk int NOT NULL,
    CONSTRAINT TransaksiDetail_Penumpang_pk PRIMARY KEY (ID_DetailPenumpang)
);

-- Table: Tempat_Duduk
CREATE TABLE Tempat_Duduk (
    ID_TempatDuduk int DEFAULT nextval('tempat_duduk_seq') NOT NULL,
    Nama_Gerbong varchar(256)  NOT NULL,
    Nomor_Kursi int  NOT NULL,
    Available boolean  NOT NULL,
    ID_Kereta  int  NOT NULL,
    Harga_Tambahan int  NOT NULL,
    CONSTRAINT Tempat_Duduk_pk PRIMARY KEY (ID_TempatDuduk)
);

-- Table: Transaksi_Makanan
CREATE TABLE Transaksi_Makanan (
    ID_TransaksiMakanan int DEFAULT nextval('transaksi_makanan_seq') NOT NULL,
    jumlah int  NOT NULL,
    ID_DetailPenumpang int  NOT NULL,
    CONSTRAINT Transaksi_Makanan_pk PRIMARY KEY (ID_TransaksiMakanan)
);

-- Table: TransaksiMakanan_Detail
CREATE TABLE TransaksiMakanan_Detail (
    ID_TransaksiMakanan int NOT NULL,
    ID_Menu int NOT NULL,
    CONSTRAINT TransaksiMakanan_Detail_pk PRIMARY KEY (ID_TransaksiMakanan,ID_Menu)
);
----------------------------------------- FUNCTION -----------------------------------------
-- Function Tempat_Duduk
CREATE OR REPLACE FUNCTION Tempat_Duduk_Func() RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO Tempat_Duduk (Nama_Gerbong, Nomor_Kursi, Available, ID_Kereta, Harga_Tambahan)
    VALUES
		('Eksekutif', 1, TRUE, NEW.ID_Kereta, 150000),
		('Eksekutif', 2, TRUE, NEW.ID_Kereta, 150000),
		('Eksekutif', 3, TRUE, NEW.ID_Kereta, 150000),
		('Eksekutif', 4, TRUE, NEW.ID_Kereta, 150000),
		('Eksekutif', 5, TRUE, NEW.ID_Kereta, 150000),
		('Ekonomi', 1, TRUE, NEW.ID_Kereta, 50000),
		('Ekonomi', 2, TRUE, NEW.ID_Kereta, 50000),
		('Ekonomi', 3, TRUE, NEW.ID_Kereta, 50000),
		('Ekonomi', 4, TRUE, NEW.ID_Kereta, 50000),
		('Ekonomi', 5, TRUE, NEW.ID_Kereta, 50000);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

-- Function Available
CREATE OR REPLACE FUNCTION Available_Func() RETURNS TRIGGER AS $$
DECLARE
    var_available BOOLEAN;
BEGIN
    SELECT Available INTO var_available FROM Tempat_Duduk WHERE ID_TempatDuduk = NEW.ID_TempatDuduk;
    IF var_available = TRUE THEN
        RETURN NEW;
    ELSE
        RAISE EXCEPTION 'Tempat duduk tidak tersedia';
        RETURN NULL;
    END IF;
END;
$$ LANGUAGE plpgsql;

-- FUNCTION Update Tempat_Duduk
CREATE OR REPLACE FUNCTION update_available_tempat_duduk() RETURNS TRIGGER AS $$
BEGIN
    UPDATE Tempat_Duduk
    SET Available = FALSE
    WHERE ID_TempatDuduk = NEW.ID_TempatDuduk;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

------------------------------------------ TRIGGER ------------------------------------------
-- Trigger Tempat_Duduk
CREATE OR REPLACE TRIGGER Tempat_Duduk_Trig
	AFTER INSERT OR UPDATE ON Kereta
	FOR EACH ROW
	EXECUTE FUNCTION Tempat_Duduk_Func();
	
-- Trigger Tidak Bisa Memilih Kursi
CREATE OR REPLACE TRIGGER Available_Trig
	BEFORE INSERT OR UPDATE ON TransaksiDetail_Penumpang
	FOR EACH ROW
	EXECUTE FUNCTION Available_Func();

-- Trigger Update Tempat_Duduk
CREATE OR REPLACE TRIGGER update_tempat_duduk_available
	BEFORE INSERT ON TransaksiDetail_Penumpang
	FOR EACH ROW
	EXECUTE FUNCTION update_available_tempat_duduk();

----------------------------------------- INSERT -----------------------------------------
-- Insert Pemesan
INSERT INTO Pemesan (Nama_Pemesan, no_HP)
VALUES
	('Abdullah', '081353275383'),
	('Ervan', '081353257549'),
    ('Andi Gunawan', '081234567890'),
    ('Siti Rahayu', '085678901234'),
    ('Budi Santoso', '087654321098'),
    ('Dewi Wulandari', '082345678901'),
    ('Hadi Prasetyo', '089012345678'),
    ('Rina Amelia', '081234567890'),
    ('Ahmad Yulianto', '085678901234'),
    ('Dian Putri', '087654321098'),
    ('Eko Nugroho', '082345678901'),
    ('Sari Mulyani', '089012345678'),
    ('Joko Santoso', '081234567890'),
    ('Rita Damayanti', '085678901234'),
    ('Syaiful Anwar', '087654321098'),
    ('Sinta Wijayanti', '082345678901'),
    ('Rizky Maulana', '089012345678'),
    ('Ayu Fitriani', '081234567890'),
    ('Feri Prasetya', '085678901234'),
    ('Wulan Indah', '087654321098'),
    ('Rahmat Santoso', '082345678901'),
    ('Yuli Sari', '089012345678'),
    ('Denny Wijaya', '081234567890'),
    ('Dini Puspita', '085678901234'),
    ('Aldo Permadi', '087654321098');

-- Insert Kereta
INSERT INTO Kereta (Nama_Kereta, Asal, Tujuan, Jam_Berangkat, Jam_Tiba, Harga, Tanggal_Pemberangkatan)
VALUES 
    ('Argo Bromo Anggrek', 'Jakarta', 'Surabaya', '08:00', '14:00', 400000, '2023-07-01'),
    ('Harina', 'Bandung', 'Surabaya', '09:00', '15:00', 200000, '2023-07-01'),
    ('Sancaka', 'Yogyakarta', 'Surabaya', '11:00', '16:00', 180000, '2023-07-01'),
    ('Argo Bromo Anggrek', 'Surabaya', 'Jakarta', '16:00', '22:00', 400000, '2023-07-01'),
    ('Harina', 'Surabaya', 'Bandung', '17:00', '23:00', 200000, '2023-07-01'),
    ('Sancaka', 'Surabaya', 'Yogyakarta', '19:00', '00:00', 180000, '2023-07-01'),
    ('Argo Bromo Anggrek', 'Jakarta', 'Surabaya', '08:00', '14:00', 400000, '2023-07-02'),
    ('Harina', 'Bandung', 'Surabaya', '09:00', '15:00', 200000, '2023-07-02'),
    ('Sancaka', 'Yogyakarta', 'Surabaya', '11:00', '16:00', 180000, '2023-07-02'),
    ('Argo Bromo Anggrek', 'Surabaya', 'Jakarta', '16:00', '22:00', 400000, '2023-07-02'),
    ('Harina', 'Surabaya', 'Bandung', '17:00', '23:00', 200000, '2023-07-02'),
    ('Sancaka', 'Surabaya', 'Yogyakarta', '19:00', '00:00', 180000, '2023-07-02'),
    ('Argo Bromo Anggrek', 'Jakarta', 'Surabaya', '08:00', '14:00', 400000, '2023-07-03'),
    ('Harina', 'Bandung', 'Surabaya', '09:00', '15:00', 200000, '2023-07-03'),
    ('Sancaka', 'Yogyakarta', 'Surabaya', '11:00', '16:00', 180000, '2023-07-03'),
    ('Argo Bromo Anggrek', 'Surabaya', 'Jakarta', '16:00', '22:00', 400000, '2023-07-03'),
    ('Harina', 'Surabaya', 'Bandung', '17:00', '23:00', 200000, '2023-07-03'),
    ('Sancaka', 'Surabaya', 'Yogyakarta', '19:00', '00:00', 180000, '2023-07-03'),
    ('Argo Bromo Anggrek', 'Jakarta', 'Surabaya', '08:00', '14:00', 400000, '2023-07-04'),
    ('Harina', 'Bandung', 'Surabaya', '09:00', '15:00', 200000, '2023-07-04'),
    ('Sancaka', 'Yogyakarta', 'Surabaya', '11:00', '16:00', 180000, '2023-07-04'),
    ('Argo Bromo Anggrek', 'Surabaya', 'Jakarta', '16:00', '22:00', 400000, '2023-07-04'),
    ('Harina', 'Surabaya', 'Bandung', '17:00', '23:00', 200000, '2023-07-04'),
    ('Sancaka', 'Surabaya', 'Yogyakarta', '19:00', '00:00', 180000, '2023-07-04'),
    ('Argo Bromo Anggrek', 'Jakarta', 'Surabaya', '08:00', '14:00', 400000, '2023-07-05'),
    ('Harina', 'Bandung', 'Surabaya', '09:00', '15:00', 200000, '2023-07-05'),
    ('Sancaka', 'Yogyakarta', 'Surabaya', '11:00', '16:00', 180000, '2023-07-05'),
    ('Argo Bromo Anggrek', 'Surabaya', 'Jakarta', '16:00', '22:00', 400000, '2023-07-05'),
    ('Harina', 'Surabaya', 'Bandung', '17:00', '23:00', 200000, '2023-07-05'),
    ('Sancaka', 'Surabaya', 'Yogyakarta', '19:00', '00:00', 180000, '2023-07-05');

-- Insert Menu_Makanan
INSERT INTO Menu_Makanan (Nama_Menu, Harga_Menu)
VALUES
    ('Nasi Goreng Spesial', 50000),
    ('Mie Ayam Bakso', 45000),
    ('Ayam Bakar Rica-Rica', 55000),
    ('Sate Ayam Madura', 60000),
    ('Ikan Bakar Bumbu Bali', 65000),
    ('Soto Betawi Komplit', 50000),
    ('Rawon Daging Sapi', 55000),
    ('Bakso Malang Super Jumbo', 60000),
    ('Nasi Campur Bali', 55000),
    ('Sate Padang', 60000);

-- Insert Transaksi_Pemesanan
INSERT INTO Transaksi_Pemesanan (Tanggal_Pemesanan, Jumlah, ID_Pemesan, ID_Kereta)
VALUES
    ('2023-06-02', 1, 1005, 2001),
    ('2023-06-05', 2, 1020, 2003),
    ('2023-06-01', 1, 1018, 2006),
    ('2023-06-09', 1, 1012, 2010),
    ('2023-06-04', 1, 1007, 2015),
    ('2023-06-03', 1, 1003, 2018),
    ('2023-06-07', 2, 1013, 2020),
    ('2023-06-06', 1, 1010, 2022),
    ('2023-06-08', 1, 1022, 2025),
    ('2023-06-01', 1, 1009, 2029),
    ('2023-06-05', 2, 1001, 2030),
    ('2023-06-03', 1, 1004, 2002),
    ('2023-06-09', 1, 1011, 2004),
    ('2023-06-06', 1, 1017, 2007),
    ('2023-06-02', 1, 1016, 2012),
    ('2023-06-04', 3, 1015, 2016),
    ('2023-06-08', 1, 1019, 2019),
    ('2023-06-07', 1, 1024, 2023),
    ('2023-06-05', 2, 1002, 2026),
    ('2023-06-01', 1, 1025, 2028);

-- Insert Feedback
INSERT INTO Feedback (Isi_Feedback, ID_TransaksiPemesanan)
VALUES
    ('Aplikasinya sudah bagus', 4011),
    ('Tolong tambahkan fitur track kereta ada di mana', 4002),
    ('UI/UX aplikasinya keren', 4017),
    ('Harga kereta relatif terjangkau. Mohon pertahankan', 4007),
    ('Tolong tambahkan fitur kirim barang di aplikasi', 4005),
    ('Harap perbaiki kualitas aplikasi pemesanan kereta', 4004),
    ('Terimakasih atas dibuatnya aplikasi ini, jadi simple banget', 4015),
    ('Mohon adakan diskon khusus anak balita', 4008),
    ('Kereta yang saya akan tumpangi, jamnya tidak mudah untuk pekerja', 4010),
    ('Estimasi kereta cukup cepat, semoga beneran cepat. Mohon diperhatikan', 4009);
	
-- Insert TransaksiDetail_Penumpang
INSERT INTO TransaksiDetail_Penumpang (nama_penumpang, No_hp, ID_TransaksiPemesanan, ID_TempatDuduk)
VALUES
    ('John Abdul Doe', '081234567890', 4001, 7003),
    ('Jane Jono Smith', '089876543210', 4002, 7023),
	('Burhanudin', '089876543210', 4002, 7024),
    ('Michael Johnson', '082345678901', 4003, 7051),
    ('Emily Davis', '087654321098', 4004, 7093),
    ('David Wilson', '083456789012', 4005, 7143),
    ('Sarah Anderson', '088765432109', 4006, 7172),
    ('Christopher Lee', '084567890123', 4007, 7191),
    ('Jennifer Brown', '089876543210', 4007, 7192),
    ('Matthew Taylor', '085678901234', 4008, 7219),
    ('Olivia Thomas', '081234567890', 4009, 7242),
    ('Robert Johnson', '087654321098', 4010, 7285),
    ('Sophia Wilson', '083456789012', 4011, 7295),
    ('James Anderson', '088765432109', 4011, 7296),
    ('Ava Lee', '084567890123', 4012, 7013),
    ('Daniel Brown', '089876543210', 4013, 7036),
    ('Mia Taylor', '085678901234', 4014, 7062),
    ('Alexander Thomas', '081234567890', 4015, 7117),
    ('Isabella Davis', '087654321098', 4016, 7152),
    ('William Smith', '083456789012', 4016, 7153),
    ('Amelia Johnson', '088765432109', 4016, 7154),
    ('Henry Wilson', '084567890123', 4017, 7182),
    ('Charlotte Anderson', '089876543210', 4018, 7226),
    ('Joseph Lee', '085678901234', 4019, 7251),
    ('Scarlett Brown', '081234567890', 4019, 7252),
    ('Andrew Taylor', '087654321098', 4020, 7275);

-- Insert Transaksi_Makanan
INSERT INTO Transaksi_Makanan (jumlah, ID_DetailPenumpang)
VALUES
    (1, 6001),
    (1, 6015),
    (1, 6003),
    (1, 6004),
    (1, 6011),
    (2, 6006),
    (1, 6007),
    (1, 6018),
    (1, 6009),
	(1,6010);

-- Insert TransaksiMakanan_Detail
INSERT INTO TransaksiMakanan_Detail (ID_TransaksiMakanan, ID_Menu)
VALUES
    (8001, 3001),
    (8002, 3002),
    (8003, 3007),
    (8004, 3004),
    (8005, 3005),
    (8006, 3002),
    (8006, 3007),
    (8007, 3008),
    (8008, 3009),
    (8009, 3010),
    (8010, 3001);
------------------------------------------- INDEX -------------------------------------------

CREATE INDEX idx_nama ON kereta (nama_kereta);

CREATE INDEX idx_tanggal_berangkat ON kereta (tanggal_pemberangkatan);

------------------------------------------- VIEW -------------------------------------------
-- View Estimasi Omset Setiap Kereta
CREATE OR REPLACE VIEW omset_per_IDKereta AS
	SELECT K.id_kereta, K.tanggal_pemberangkatan, K.nama_kereta, K.Tujuan, (SUM(T.harga_tambahan) + COUNT(T.harga_tambahan)*K.harga) AS omset
	FROM tempat_duduk T
	INNER JOIN kereta K ON T.id_kereta = K.id_kereta AND T.available = FALSE
	GROUP BY K.id_kereta, K.nama_kereta;
	SELECT * FROM omset_per_IDKereta;

-- View Ketersediaan Kursi
CREATE OR REPLACE VIEW Ketersediaan_Kursi AS
	SELECT K.id_kereta, K.tanggal_pemberangkatan, K.nama_kereta, K.asal, K.Tujuan, T.nama_gerbong AS Kelas, COUNT(id_tempatduduk) AS available
	FROM tempat_duduk T
	INNER JOIN kereta K ON T.id_kereta = K.id_kereta AND T.available = TRUE
	GROUP BY K.id_kereta, K.tanggal_pemberangkatan, K.nama_kereta, K.asal, K.Tujuan, Kelas
	ORDER BY id_kereta ASC;
	SELECT * FROM Ketersediaan_Kursi;
	
-- View Pemesan Makanan
CREATE OR REPLACE VIEW Pemesan_Makanan AS
	SELECT T.Nama_Penumpang, M.Nama_Menu
	FROM TransaksiDetail_Penumpang T
	INNER JOIN Transaksi_Makanan P ON T.ID_DetailPenumpang = P.ID_DetailPenumpang
	INNER JOIN TransaksiMakanan_Detail A ON P.id_transaksimakanan = A.ID_TransaksiMakanan
	INNER JOIN Menu_Makanan M ON A.ID_Menu = M.ID_Menu;
	SELECT * FROM Pemesan_Makanan;
	
-- View Kereta Terlaris --
CREATE OR REPLACE VIEW Kereta_terlaris AS
	SELECT K.Nama_Kereta, COUNT(*) AS Jumlah_Pemesanan
	FROM Kereta K
	JOIN Transaksi_Pemesanan TP ON K.ID_Kereta = TP.ID_Kereta
	GROUP BY K.Nama_Kereta
	ORDER BY Jumlah_Pemesanan DESC
	LIMIT 1;
	SELECT * FROM Kereta_terlaris;
	
------------------------------------------- PROCEDURE -------------------------------------------
CREATE OR REPLACE PROCEDURE updateHargaKereta(idKereta int, diskon float)
	LANGUAGE plpgsql AS $$
	BEGIN
		UPDATE Kereta
		SET Harga = Harga - (Harga * diskon)
		WHERE id_Kereta = idKereta;
		RAISE INFO 'Harga telah diupdate';
	END $$;

CALL updateHargaKereta(2001, 0.2)