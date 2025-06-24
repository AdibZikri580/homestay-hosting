-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 22, 2025 at 01:59 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `homestayfinder`
--

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--

CREATE TABLE `bookings` (
  `booking_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `homestay_id` int(11) NOT NULL,
  `check_in` date NOT NULL,
  `check_out` date NOT NULL,
  `total_price` decimal(10,2) NOT NULL,
  `total_guests` int(11) DEFAULT NULL,
  `status` enum('pending','approve','reject') DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bookings`
--

INSERT INTO `bookings` (`booking_id`, `user_id`, `homestay_id`, `check_in`, `check_out`, `total_price`, `total_guests`, `status`, `created_at`) VALUES
(2, 1, 9, '2025-06-03', '2025-06-08', 950.00, 6, 'approve', '2025-06-07 07:37:48'),
(5, 1, 5, '2025-06-08', '2025-06-09', 202.00, 1, 'reject', '2025-06-07 17:19:05'),
(6, 10, 8, '2025-06-11', '2025-06-14', 174.00, 5, 'approve', '2025-06-11 04:42:18');

-- --------------------------------------------------------

--
-- Table structure for table `homestays`
--

CREATE TABLE `homestays` (
  `homestay_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `name` varchar(150) NOT NULL,
  `description` text DEFAULT NULL,
  `address` text DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `state` varchar(100) DEFAULT NULL,
  `price_per_night` decimal(10,2) NOT NULL,
  `max_guests` int(11) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `has_wifi` tinyint(1) DEFAULT 0,
  `has_parking` tinyint(1) DEFAULT 0,
  `has_aircond` tinyint(1) DEFAULT 0,
  `has_tv` tinyint(1) DEFAULT 0,
  `has_kitchen` tinyint(1) DEFAULT 0,
  `has_washing_machine` tinyint(1) DEFAULT 0,
  `num_bedrooms` int(11) DEFAULT 1,
  `num_bathrooms` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `homestays`
--

INSERT INTO `homestays` (`homestay_id`, `user_id`, `name`, `description`, `address`, `city`, `state`, `price_per_night`, `max_guests`, `created_at`, `has_wifi`, `has_parking`, `has_aircond`, `has_tv`, `has_kitchen`, `has_washing_machine`, `num_bedrooms`, `num_bathrooms`) VALUES
(3, 4, 'Jenny Homestay', 'Jenny Homestay features accommodations in Teluk Intan. This homestay offers free private parking, a shared kitchen, and free Wifi.\r\n\r\nSultan Azlan Shah Airport is 50 miles from the property.', 'Lot 32, Lorong Cengkih H2/1', 'Teluk Intan', 'Perak', 72.00, 10, '2025-06-06 12:24:22', 1, 1, 1, 1, 1, 1, 5, 6),
(4, 4, 'Berkat D\'Sawah', 'Homestay Berkat D\'sawah Tasek Berangan Pasir Mas in Pasir Mas provides accommodations with a garden, a terrace, and barbecue facilities. With free private parking, the property is 18 miles from Handicraft Village and Craft Museum', '157-A Kampung Tasek Berangan', 'Pasir Mas', 'Kelantan', 219.00, 10, '2025-06-06 12:30:25', 0, 1, 1, 1, 1, 0, 4, 3),
(5, 4, 'Anggun Homestay', 'Situated in Kuala Kerai in the Kelantan region, Homestay Anggun features accommodation with free private parking. This villa offers a terrace.\r\n\r\nThis villa will provide guests with 3 bedrooms, a flat-screen TV and air conditioning.\r\n\r\nThe nearest airport is Sultan Ismail Petra Airport, 84 km from the villa.', 'Lot 1 Lorong Firdaus 5, Kampung Pahi', 'Kuala Krai', 'Kelantan', 202.00, 3, '2025-06-06 12:35:11', 0, 1, 1, 1, 1, 1, 3, 2),
(6, 4, 'Seri Kenangan Holiday Homestay', 'The car parking and the Wi-Fi are always free, so you can stay in touch and come and go as you please. Conveniently situated in the Samarahan part of Kuching, this property puts you close to attractions and interesting dining options. Don\'t leave before paying a visit to the famous Semenggoh Nature Reserve. This 5-star property is packed with in-house facilities to improve the quality and joy of your stay.', 'B922 Kampung Meranek', 'Kuching', 'Sarawak', 160.00, 6, '2025-06-06 12:39:13', 1, 1, 1, 1, 1, 1, 2, 1),
(7, 4, 'Mossaz Leisure Suites ', 'Mossaz Leisure Suites Kuala Lumpur features free Wifi and rooms with air conditioning in Kuala Lumpur. The property is around 5.8 miles from Federal Territory Mosque, 6.6 miles from Evolve Concept Mall, and 7.7 miles from Putra World Trade Center. ', 'Empire City, No.8, Jalan Damansara, PJU 8', 'Petaling Jaya', 'Selangor', 78.00, 8, '2025-06-06 12:49:46', 1, 1, 1, 1, 1, 1, 4, 2),
(8, 4, 'Jasa Resort', '.', 'Lot 1222, Kampung Kuala Kenau', 'Sungai Lembing', 'Pahang', 58.00, 9, '2025-06-06 12:54:08', 1, 1, 1, 1, 0, 0, 6, 7),
(9, 4, 'De\'69', 'Featuring a terrace, Homestay De\'69 features accommodations in Jitra. With free private parking, the property is 15 miles from Asian Cultural Village and 15 miles from Dinosaur Park Dannok.', '9123B Kampung Padang Lorak', 'Jitra', 'Kedah', 190.00, 6, '2025-06-06 12:58:00', 0, 1, 1, 1, 1, 1, 3, 2),
(11, 4, 'Homestay Pontian', 'Offering garden views, De Pontian Homestay is an accommodation located in Pontian Besar, 23 km from Pulau Kukup National Park and 27 km from Gunung.', 'Jalan Sekolah Arab, Kampung Duku,', 'Pontian', 'Johor', 300.00, 10, '2025-06-11 10:45:45', 1, 1, 1, 1, 1, 0, 3, 2),
(12, 4, 'Rumah Pantai Homestay', 'This homestay offers a peaceful and relaxing environment, perfect for guests looking to unwind by the beach. With comfortable rooms and a homely atmosphere, it is an ideal choice for those visiting the area for a serene getaway or exploring nearby attractions. ', '4837, Jalan Geliga Pantai 3, Kampung Geliga Besar', 'Chukai', 'Terengganu', 490.00, 15, '2025-06-11 16:16:51', 1, 1, 1, 1, 1, 1, 5, 4),
(13, 4, 'Tanjung Damai', 'Tanjung Damai Homestay is located in Tanjung Piandang. The house is located on the edge of a rice field and close to Ban Pecah, God willing, it can provide comfort to visitors.', 'Jln Pantai, Batu 10', 'Tanjung Piandang', 'Perak', 180.00, 10, '2025-06-11 17:08:15', 0, 1, 1, 0, 1, 1, 2, 1),
(14, 5, 'Gading Chalet', 'Donât call it a hotel, call it a home away from home ð Where the fun never stops ð We have swimming pool right in front of your doorsteps, easy for you to monitor your kids having fun in the water.\r\n1km restaurants 1km mini market 5km beach area 5km shopping mall', '3263, Jalan Jeram, Kampung Buluh Gading', 'Kuala Terengganu', 'Terengganu', 230.00, 10, '2025-06-17 12:49:59', 1, 1, 1, 1, 1, 1, 2, 2),
(15, 5, 'Man Homestay', '.', 'Lot PT 00108K, Jalan Kg Bukit Nenasi, Kampung Tepoh', 'Kuala Terengganu', 'Terengganu', 70.00, 10, '2025-06-17 12:53:02', 1, 1, 1, 1, 1, 1, 3, 2),
(16, 5, 'WIWI Village', 'Wiwi Village at Lorong Seberang 1, Kemasik, is a charming coastal village in Kemaman, Terengganu. Known for its serene atmosphere and friendly community, the village offers a glimpse into traditional Malaysian coastal life. Located near beautiful beaches like Pantai Kemasik, itâs a peaceful spot with simple homes, local eateries, and easy access to nature. Perfect for those seeking a quiet retreat or a taste of Terengganuâs culture.', 'Lorong Seberang 1 Kemasik', 'Kemaman', 'Terengganu', 124.00, 7, '2025-06-17 12:57:22', 1, 1, 1, 1, 1, 1, 3, 2),
(17, 5, 'Tiga Penarik', 'Tiga Penarik is a charming and peaceful homestay located in the scenic village of Kampung Bukit Chalok, near Permaisuri, Terengganu. Surrounded by lush greenery and close to local attractions like Pantai Penarik (a beautiful, less crowded beach), this homestay offers a relaxing retreat with a traditional Malaysian vibe. The property features a cozy, well-maintained house with a simple yet comfortable setup, perfect for families or small groups looking to experience Terengganuâs laid-back coastal lifestyle.', 'Lot 90, Jalan Penarik-Kuala Terengganu, Kampung Bukit Chalok', 'Permaisuri', 'Terengganu', 282.00, 8, '2025-06-17 13:02:09', 1, 1, 1, 1, 1, 1, 3, 2),
(18, 5, 'Fishing Village', 'Kampung Seberang Marang is a traditional fishing village nestled along the scenic Marang River, near the popular Pulau Kapas departure point. This charming village offers an authentic glimpse into Terengganuâs coastal life, with wooden stilt houses, colorful fishing boats (perahu), and a bustling riverside atmosphere. The locals rely on fishing as their main livelihood, and visitors can witness the daily catch being brought in, sold at the local market, or even enjoy fresh seafood at nearby eateries.', 'Lot 2279, Jalan Lama Seberang Marang', 'Marang', 'Terengganu', 149.00, 6, '2025-06-17 13:06:25', 1, 1, 1, 1, 0, 0, 2, 1),
(19, 5, 'YB Guest House', 'YB Guest House is a budget-friendly accommodation located in Chukai, the bustling commercial center of Kemaman, Terengganu. Ideal for travelers, backpackers, or short-term stays, this guesthouse offers basic amenities with convenient access to local eateries, shops, and major roads (like the East Coast Highway). The place is simple, clean, and functional, suitable for those passing through or exploring nearby attractions like Pantai Kemasik or Kemaman Riverfront.', ' PT 15795, Jalan Taman Geliga Baiduri', 'Chukai', 'Terenganu', 400.00, 12, '2025-06-17 13:09:33', 1, 1, 1, 1, 1, 1, 4, 2),
(20, 5, 'Danial Homestay', 'Danial Homestay is a traditional Malay-style guesthouse nestled in the peaceful village of Kampung Kolam Ajil, offering a rustic countryside experience in Terengganu. Surrounded by lush greenery and a serene atmosphere, this homestay is perfect for travelers seeking an authentic rural retreat away from city crowds.', 'Lot 60777, Kampung Kolam Ajil', 'Ajil', 'Terengganu', 247.00, 10, '2025-06-17 13:23:49', 1, 1, 1, 1, 1, 1, 4, 2),
(21, 5, 'Tijami Village & Resort', 'Tijami Village & Resort is a tranquil beachfront getaway nestled in the quiet fishing village of Kampung Mangkok, near Permaisuri. Combining traditional Terengganu charm with modern comforts, this resort offers a serene escape with direct access to a secluded stretch of sandy beach. The property features rustic wooden chalets and a relaxing atmosphere, perfect for those seeking peace, nature, and a taste of coastal Terengganu life.', 'Lot 1568, Jalan Penarik-Terengganu, Kampung Mangkok', 'Permaisuri', 'Terengganu', 236.00, 20, '2025-06-17 13:28:24', 1, 1, 1, 1, 1, 1, 6, 6),
(22, 5, 'Haura Homestay', 'Haura Homestay offers an authentic Terengganu coastal living experience in the historic Seberang Takir area, just 15 minutes from Kuala Terengganu city center. This family-run homestay sits in a working fishing village, where guests can witness daily catches, wooden boat-making (perahu buatan tangan), and stunning sunset views over the Terengganu River estuary.\r\n\r\nThe property features a traditional Malay wooden house with modern comforts, blending cultural immersion with convenience.', 'Lot 6011, Jalan Fikri, Seberang Takir', 'Kuala Terengganu', 'Terengganu', 251.00, 10, '2025-06-17 13:31:52', 1, 1, 1, 1, 1, 1, 2, 1),
(23, 5, 'The Pine House', 'Nestled in the tranquil highlands of Kuala Berang, The Pine House is a rustic-chic wooden retreat surrounded by lush greenery and cool mountain air. Designed with a blend of traditional Malay architecture and modern comforts, this property offers a peaceful escape near Kenny Hill (Bukit Kenny) and the Terengganu highlands. Perfect for nature lovers, families, or groups seeking serenity away from the coast.', 'Lot 54357, 54358, 54359, Jalan Haji Bakar, Kampung Paya Besar', 'Kuala Berang', 'Terengganu', 350.00, 15, '2025-06-17 13:34:46', 1, 1, 1, 1, 1, 1, 4, 2);

-- --------------------------------------------------------

--
-- Table structure for table `images`
--

CREATE TABLE `images` (
  `image_id` int(11) NOT NULL,
  `homestay_id` int(11) NOT NULL,
  `image_path` varchar(255) NOT NULL,
  `uploaded_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `images`
--

INSERT INTO `images` (`image_id`, `homestay_id`, `image_path`, `uploaded_at`) VALUES
(4, 3, 'uploads/jennyHomestay.jpg', '2025-06-06 12:24:22'),
(5, 4, 'uploads/Berkat D\'sawah.jpg', '2025-06-06 12:30:25'),
(6, 5, 'uploads/AnggunHomestay.jpg', '2025-06-06 12:35:11'),
(7, 6, 'uploads/Seri Kenangan Holiday Homestay.jpg', '2025-06-06 12:39:13'),
(8, 7, 'uploads/Mossaz Leisure Suites.jpg', '2025-06-06 12:49:46'),
(9, 8, 'uploads/Jasa Resort.jpg', '2025-06-06 12:54:08'),
(10, 9, 'uploads/De\'69.jpg', '2025-06-06 12:58:00'),
(12, 11, 'uploads/4fe3a771-937c-44ff-a3c8-515fb7fd843f.png', '2025-06-11 10:45:45'),
(13, 12, '3ebc1e71-0d75-46d4-b0f0-92c592ed1fb5.jpeg', '2025-06-11 16:16:51'),
(14, 13, 'eedcc7bf-89fe-43f4-a665-726ad4f41248.jpg', '2025-06-11 17:08:15'),
(15, 14, '19a985df-6245-464b-92b2-b96a39788c23.jpg', '2025-06-17 12:49:59'),
(16, 15, 'c0b9d2cb-eae5-44e4-b991-fee1a27f22dc.jpg', '2025-06-17 12:53:02'),
(17, 16, 'c6e28306-3569-4b80-b274-31c809d37797.jpg', '2025-06-17 12:57:22'),
(18, 17, '0ba0d073-b72f-4462-922d-f814747611f0.jpg', '2025-06-17 13:02:09'),
(19, 18, '6c62f01d-2275-4f89-bba8-0f4428234517.jpg', '2025-06-17 13:06:25'),
(20, 19, '3256ffac-5f66-4d85-9f62-a06fa6d7d7ca.jpg', '2025-06-17 13:09:33'),
(21, 20, 'a1d84bcd-32c5-41fc-aa3f-3abb44d51ee2.jpg', '2025-06-17 13:23:49'),
(22, 21, '85660d95-2e76-4ebb-b58c-d01c1d47d9f5.jpg', '2025-06-17 13:28:24'),
(23, 22, 'c8ea9f59-8e81-4c51-a8d8-92ca7eff48ae.jpg', '2025-06-17 13:31:53'),
(24, 23, '036f81d4-be9c-4dff-bec3-bf46b9840699.jpg', '2025-06-17 13:34:46');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `user_type` enum('customer','homestay_owner') NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `full_name`, `email`, `password`, `phone`, `user_type`, `created_at`) VALUES
(1, 'Muhammad Adib Zikri bin Zakaria', 'adibzikri11@gmail.com', 'Adib2710_', '0199602133', 'customer', '2025-05-19 15:27:59'),
(4, 'Aisya Maisara binti Zakaria', 'aisyamaisara24@gmail.com', 'Aisya06_', '01110975433', 'homestay_owner', '2025-05-21 12:22:02'),
(5, 'Muhammad Alif Habibie bin Mohd Zaki', 'alifhabibie06@gmail.com', 'Aliff1', '01928561544', 'homestay_owner', '2025-05-21 12:56:10'),
(6, 'Aiman Hakim bin Roslan', 'aimanhakim.roslan98@gmail.com', 'owner', '01126748392', 'homestay_owner', '2025-06-06 12:08:22'),
(7, 'Nurul Izzah binti Zulkifli', 'nurul.izzahzulki23@yahoo.com', 'owner', '01758321049', 'homestay_owner', '2025-06-06 12:10:11'),
(8, 'Mohamad Faiz bin Ramli', 'mfaiz.ramli92@outlook.com', 'owner', '01294837751', 'homestay_owner', '2025-06-06 12:10:58'),
(9, 'Siti Aisyah binti Harun', 'aisyah.harun88@gmail.com', 'owner', '01872203468', 'homestay_owner', '2025-06-06 12:12:01'),
(10, 'Muhammad Ali bin Abu', 'aliabu123@gmail.com', 'customer', '0123456789', 'customer', '2025-06-11 04:35:08');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`booking_id`),
  ADD KEY `customer_id` (`user_id`),
  ADD KEY `homestay_id` (`homestay_id`);

--
-- Indexes for table `homestays`
--
ALTER TABLE `homestays`
  ADD PRIMARY KEY (`homestay_id`),
  ADD KEY `owner_id` (`user_id`);

--
-- Indexes for table `images`
--
ALTER TABLE `images`
  ADD PRIMARY KEY (`image_id`),
  ADD KEY `homestay_id` (`homestay_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bookings`
--
ALTER TABLE `bookings`
  MODIFY `booking_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `homestays`
--
ALTER TABLE `homestays`
  MODIFY `homestay_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `images`
--
ALTER TABLE `images`
  MODIFY `image_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bookings`
--
ALTER TABLE `bookings`
  ADD CONSTRAINT `bookings_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `bookings_ibfk_2` FOREIGN KEY (`homestay_id`) REFERENCES `homestays` (`homestay_id`) ON DELETE CASCADE;

--
-- Constraints for table `homestays`
--
ALTER TABLE `homestays`
  ADD CONSTRAINT `homestays_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `images`
--
ALTER TABLE `images`
  ADD CONSTRAINT `images_ibfk_1` FOREIGN KEY (`homestay_id`) REFERENCES `homestays` (`homestay_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
