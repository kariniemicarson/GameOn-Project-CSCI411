USE gameon_db;
START TRANSACTION;

INSERT INTO users (
    first_name, last_name, email, password_hash, role, phone,
    profile_pic_url, bio, skill_level
) VALUES
('Jordan',  'Blake',   'jordan.blake@example.com',   'hash_jordan_2026',  'player',    '555-0101', 'https://example.com/profiles/jordan.jpg',  'Competitive guard who organizes weekly runs.', 7),
('Casey',   'Morgan',  'casey.morgan@example.com',   'hash_casey_2026',   'agent',     '555-0102', 'https://example.com/profiles/casey.jpg',   'Represents athletes across city leagues.', 6),
('Taylor',  'Reed',    'taylor.reed@example.com',    'hash_taylor_2026',  'scout',     '555-0103', 'https://example.com/profiles/taylor.jpg',  'Scouts talent and tracks player progress.', 8),
('Avery',   'Stone',   'avery.stone@example.com',    'hash_avery_2026',   'organizer', '555-0104', 'https://example.com/profiles/avery.jpg',   'Coordinates tournaments and schedules.', 5),
('Riley',   'Chen',    'riley.chen@example.com',     'hash_riley_2026',   'player',    '555-0105', 'https://example.com/profiles/riley.jpg',   'Versatile athlete with strong fundamentals.', 9),
('Cameron', 'Wells',   'cameron.wells@example.com',  'hash_cameron_2026', 'admin',     '555-0106', 'https://example.com/profiles/cameron.jpg', 'Platform administrator and mentor.', 6),
('Morgan',  'Patel',   'morgan.patel@example.com',   'hash_morgan_2026',  'player',    '555-0107', 'https://example.com/profiles/morgan.jpg',  'Team-first player focused on consistency.', 4),
('Quinn',   'Rivera',  'quinn.rivera@example.com',   'hash_quinn_2026',   'agent',     '555-0108', 'https://example.com/profiles/quinn.jpg',   'Negotiates club and sponsorship deals.', 7),
('Hayden',  'Brooks',  'hayden.brooks@example.com',  'hash_hayden_2026',  'scout',     '555-0109', 'https://example.com/profiles/hayden.jpg',  'Evaluates game film and live matches.', 8),
('Skyler',  'James',   'skyler.james@example.com',   'hash_skyler_2026',  'organizer', '555-0110', 'https://example.com/profiles/skyler.jpg',  'Builds community events for local athletes.', 5);

INSERT INTO sports (sport_name, description, max_players_per_team) VALUES
('Basketball',       'Indoor team sport focused on shooting and defense.', 5),
('Soccer',           'Outdoor team sport played with feet and strategy.', 11),
('Volleyball',       'Net-based team sport emphasizing rallies.', 6),
('Tennis',           'Racquet sport played in singles or doubles.', 2),
('Baseball',         'Bat-and-ball sport with innings and fielding.', 9),
('Softball',         'Fast-paced bat-and-ball variation of baseball.', 10),
('Football',         'Contact team sport with offense and defense units.', 11),
('Ultimate Frisbee', 'Non-contact disc sport with continuous movement.', 7),
('Rugby',            'High-intensity running and tackling team sport.', 15),
('Badminton',        'Racquet sport with shuttle and quick reflexes.', 2);

INSERT INTO positions (sport_id, position_name, abbreviation) VALUES
(1,  'Point Guard',        'PG'),
(2,  'Striker',            'ST'),
(3,  'Setter',             'SET'),
(4,  'Singles Player',     'SP'),
(5,  'Pitcher',            'P'),
(6,  'Catcher',            'C'),
(7,  'Quarterback',        'QB'),
(8,  'Handler',            'HND'),
(9,  'Fly-Half',           'FH'),
(10, 'Singles Specialist', 'SS');

INSERT INTO locations (
    name, address, latitude, longitude, facility_type, is_indoor, capacity
) VALUES
('Downtown Rec Center',     '100 Main St, Seattle, WA',        47.6062095, -122.3320708, 'rec_center', 1, 120),
('Lakeview Soccer Field',   '250 Lake Dr, Seattle, WA',        47.6204220, -122.3493580, 'field',      0, 200),
('Northside Gym',           '75 Pine Ave, Seattle, WA',        47.6155700, -122.3411000, 'gym',        1, 180),
('Riverside Park Courts',   '410 River Rd, Seattle, WA',       47.5981220, -122.3244500, 'court',      0, 90),
('Eastside Baseball Complex','920 East Way, Bellevue, WA',     47.6101497, -122.2015159, 'field',      0, 350),
('West End Softball Field', '1210 Cedar Ln, Seattle, WA',      47.5920010, -122.3650010, 'field',      0, 280),
('Central Stadium',         '500 Victory Blvd, Seattle, WA',   47.6038321, -122.3300624, 'field',      0, 1000),
('Hilltop Ultimate Grounds','890 Summit St, Seattle, WA',      47.6285500, -122.3381000, 'park',       0, 220),
('South Rugby Park',        '1330 South Pkwy, Seattle, WA',    47.5802300, -122.3156700, 'park',       0, 300),
('City Badminton Hall',     '67 Shuttle Ct, Seattle, WA',      47.6119000, -122.3308000, 'gym',        1, 140);

INSERT INTO games (
    sport_id, location_id, created_by, status, scheduled_time,
    max_players, current_players, skill_level_req
) VALUES
(1,  1,  1,  'completed', '2026-03-20 18:00:00', 10, 1, 'intermediate'),
(2,  2,  2,  'completed', '2026-03-21 17:30:00', 22, 1, 'beginner'),
(3,  3,  3,  'completed', '2026-03-22 19:00:00', 12, 1, 'intermediate'),
(4,  4,  4,  'completed', '2026-03-23 16:00:00', 4,  1, 'advanced'),
(5,  5,  5,  'completed', '2026-03-24 18:15:00', 18, 1, 'any'),
(6,  6,  6,  'completed', '2026-03-25 18:45:00', 20, 1, 'beginner'),
(7,  7,  7,  'completed', '2026-03-26 20:00:00', 22, 1, 'advanced'),
(8,  8,  8,  'completed', '2026-03-27 17:00:00', 14, 1, 'intermediate'),
(9,  9,  9,  'completed', '2026-03-28 15:30:00', 30, 1, 'advanced'),
(10, 10, 10, 'completed', '2026-03-29 14:00:00', 4,  1, 'any');

INSERT INTO teams (game_id, team_name, score) VALUES
(1,  'Hoops Heroes',      72),
(2,  'Goal Getters',      3),
(3,  'Net Ninjas',        2),
(4,  'Ace Squad',         6),
(5,  'Diamond Dawgs',     8),
(6,  'Softball Stars',    7),
(7,  'Gridiron Giants',   24),
(8,  'Flying Discs',      15),
(9,  'Rugby Rockets',     21),
(10, 'Shuttle Smashers',  5);

-- bridge tables

INSERT INTO game_players (
    game_id, user_id, team_id, position_id, status
) VALUES
(1,  1,  1,  1,  'confirmed'),
(2,  2,  2,  2,  'confirmed'),
(3,  3,  3,  3,  'confirmed'),
(4,  4,  4,  4,  'confirmed'),
(5,  5,  5,  5,  'confirmed'),
(6,  6,  6,  6,  'confirmed'),
(7,  7,  7,  7,  'confirmed'),
(8,  8,  8,  8,  'confirmed'),
(9,  9,  9,  9,  'confirmed'),
(10, 10, 10, 10, 'confirmed');

INSERT INTO game_stats (game_player_id, stat_type, stat_value) VALUES
(1,  'points',      24),
(2,  'goals',       2),
(3,  'assists',     5),
(4,  'aces',        3),
(5,  'runs',        2),
(6,  'rbis',        3),
(7,  'touchdowns',  2),
(8,  'scores',      4),
(9,  'tries',       1),
(10, 'points',      21);

INSERT INTO game_results (game_id, winning_team_id, completed_at, notes) VALUES
(1,  1,  '2026-03-20 19:30:00', 'Home side controlled tempo late in the game.'),
(2,  2,  '2026-03-21 19:10:00', 'Winning team scored in extra time.'),
(3,  3,  '2026-03-22 20:20:00', 'Strong serving run decided the final set.'),
(4,  4,  '2026-03-23 17:10:00', 'Straight-set victory with aggressive baseline play.'),
(5,  5,  '2026-03-24 20:00:00', 'Late inning rally sealed the game.'),
(6,  6,  '2026-03-25 20:15:00', 'Disciplined defense preserved a narrow lead.'),
(7,  7,  '2026-03-26 22:10:00', 'Dominant second half performance.'),
(8,  8,  '2026-03-27 18:45:00', 'Fast break offense created separation.'),
(9,  9,  '2026-03-28 17:20:00', 'Physical contest won by stronger set pieces.'),
(10, 10, '2026-03-29 15:30:00', 'Consistent shot placement secured the match.');

INSERT INTO user_sports (user_id, sport_id, years_experience) VALUES
(1,  1,  5),
(2,  2,  7),
(3,  3,  6),
(4,  4,  8),
(5,  5,  9),
(6,  6,  4),
(7,  7,  10),
(8,  8,  5),
(9,  9,  7),
(10, 10, 3);

INSERT INTO user_positions (user_id, position_id, is_primary) VALUES
(1,  1,  1),
(2,  2,  1),
(3,  3,  1),
(4,  4,  1),
(5,  5,  1),
(6,  6,  1),
(7,  7,  1),
(8,  8,  1),
(9,  9,  1),
(10, 10, 1);

-- recruitment entities

INSERT INTO clubs (
    club_name, sport_id, city, state, description, founded_year
) VALUES
('Seattle Swish Club',            1,  'Seattle',   'WA', 'Community-driven basketball club.', 2015),
('Puget Sound FC',                2,  'Seattle',   'WA', 'Competitive soccer program for local talent.', 2012),
('Cascade Volleyball Collective', 3,  'Tacoma',    'WA', 'Player development focused volleyball club.', 2018),
('Rainier Tennis Group',          4,  'Bellevue',  'WA', 'Tennis training and match-play events.', 2011),
('Emerald Baseball League',       5,  'Everett',   'WA', 'Regional baseball club with youth pipeline.', 2009),
('Harbor Softball Association',   6,  'Kirkland',  'WA', 'Recreational and competitive softball teams.', 2016),
('Northwest Football Club',       7,  'Renton',    'WA', 'Football club with seasonal league play.', 2010),
('Sound Ultimate Union',          8,  'Seattle',   'WA', 'Ultimate program for mixed-level athletes.', 2019),
('Seattle Rugby Fellowship',      9,  'Shoreline', 'WA', 'Rugby club emphasizing fundamentals and fitness.', 2008),
('Metro Badminton Society',       10, 'Redmond',   'WA', 'Badminton ladder and tournament community.', 2017);

INSERT INTO agents (user_id, agency_name, license_number) VALUES
(2,  'Northwest Talent Partners',  'AGT-1001'),
(8,  'Rivera Sports Management',   'AGT-1002'),
(3,  'Peak Scout Agency',          'AGT-1003'),
(4,  'Stone Athlete Group',        'AGT-1004'),
(6,  'Wells Pro Representation',   'AGT-1005'),
(9,  'Brooks Elite Sports',        'AGT-1006'),
(1,  'Blake Player Advocates',     'AGT-1007'),
(5,  'Chen Performance Agency',    'AGT-1008'),
(7,  'Patel Athletic Advisors',    'AGT-1009'),
(10, 'James Sports Network',       'AGT-1010');

INSERT INTO sponsors (sponsor_name, industry, contact_email, website) VALUES
('Summit Energy',      'Energy',      'partnerships@summitenergy.com',   'https://www.summitenergy.com'),
('Harbor Health',      'Healthcare',  'sports@harborhealth.org',         'https://www.harborhealth.org'),
('Apex Apparel',       'Retail',      'teams@apexapparel.com',           'https://www.apexapparel.com'),
('Cascade Tech',       'Technology',  'marketing@cascadetech.io',        'https://www.cascadetech.io'),
('Northline Logistics', 'Logistics',  'sponsorships@northlinelog.com',   'https://www.northlinelog.com'),
('BluePeak Finance',   'Finance',     'community@bluepeakfinance.com',   'https://www.bluepeakfinance.com'),
('GreenGrid Solar',    'Energy',      'athletics@greengridsolar.com',    'https://www.greengridsolar.com'),
('Trailhead Nutrition','Nutrition',   'support@trailheadnutrition.com',  'https://www.trailheadnutrition.com'),
('EverWave Media',     'Media',       'ads@everwavemedia.com',           'https://www.everwavemedia.com'),
('Urban Transit Co',   'Transportation','sports@urbantransit.co',        'https://www.urbantransit.co');

INSERT INTO club_members (club_id, user_id, member_role, joined_date) VALUES
(1,  1,  'captain', '2024-01-15'),
(2,  2,  'member',  '2024-02-03'),
(3,  3,  'coach',   '2024-02-20'),
(4,  4,  'manager', '2024-03-05'),
(5,  5,  'captain', '2024-03-18'),
(6,  6,  'member',  '2024-04-01'),
(7,  7,  'coach',   '2024-04-12'),
(8,  8,  'manager', '2024-04-26'),
(9,  9,  'captain', '2024-05-10'),
(10, 10, 'member',  '2024-05-24');

INSERT INTO club_sponsors (
    club_id, sponsor_id, amount, start_date, end_date
) VALUES
(1,  1,  5000.00, '2025-01-01', '2025-12-31'),
(2,  2,  6200.00, '2025-01-15', '2025-12-31'),
(3,  3,  4500.00, '2025-02-01', '2025-12-31'),
(4,  4,  7000.00, '2025-02-15', '2025-12-31'),
(5,  5,  8000.00, '2025-03-01', '2025-12-31'),
(6,  6,  3900.00, '2025-03-15', '2025-12-31'),
(7,  7,  9100.00, '2025-04-01', '2025-12-31'),
(8,  8,  4300.00, '2025-04-15', '2025-12-31'),
(9,  9,  7600.00, '2025-05-01', '2025-12-31'),
(10, 10, 5200.00, '2025-05-15', '2025-12-31');

INSERT INTO club_agents (club_id, agent_id, contract_start, contract_end) VALUES
(1,  1,  '2025-02-01', '2027-02-01'),
(2,  2,  '2025-02-15', '2027-02-15'),
(3,  3,  '2025-03-01', '2027-03-01'),
(4,  4,  '2025-03-15', '2027-03-15'),
(5,  5,  '2025-04-01', '2027-04-01'),
(6,  6,  '2025-04-15', '2027-04-15'),
(7,  7,  '2025-05-01', '2027-05-01'),
(8,  8,  '2025-05-15', '2027-05-15'),
(9,  9,  '2025-06-01', '2027-06-01'),
(10, 10, '2025-06-15', '2027-06-15');

INSERT INTO user_agents (user_id, agent_id, start_date, end_date) VALUES
(1,  1,  '2025-01-10', '2026-12-31'),
(2,  2,  '2025-01-17', '2026-12-31'),
(3,  3,  '2025-01-24', '2026-12-31'),
(4,  4,  '2025-01-31', '2026-12-31'),
(5,  5,  '2025-02-07', '2026-12-31'),
(6,  6,  '2025-02-14', '2026-12-31'),
(7,  7,  '2025-02-21', '2026-12-31'),
(8,  8,  '2025-02-28', '2026-12-31'),
(9,  9,  '2025-03-07', '2026-12-31'),
(10, 10, '2025-03-14', '2026-12-31');

INSERT INTO user_sponsors (
    user_id, sponsor_id, amount, start_date, end_date
) VALUES
(1,  1,  1200.00, '2025-01-01', '2025-12-31'),
(2,  2,  1500.00, '2025-01-05', '2025-12-31'),
(3,  3,  1100.00, '2025-01-10', '2025-12-31'),
(4,  4,  1750.00, '2025-01-15', '2025-12-31'),
(5,  5,  2000.00, '2025-01-20', '2025-12-31'),
(6,  6,  1000.00, '2025-01-25', '2025-12-31'),
(7,  7,  2200.00, '2025-02-01', '2025-12-31'),
(8,  8,  1300.00, '2025-02-05', '2025-12-31'),
(9,  9,  1800.00, '2025-02-10', '2025-12-31'),
(10, 10, 1400.00, '2025-02-15', '2025-12-31');

-- social entities

INSERT INTO messages (
    sender_id, receiver_id, game_id, content, sent_at, is_read
) VALUES
(1,  2,  1,  'Great game tonight. Want a rematch next week?', '2026-03-20 20:00:00', 1),
(2,  3,  2,  'I have a player recommendation for your club.',  '2026-03-21 20:05:00', 0),
(3,  4,  3,  'Scouting notes are uploaded to your dashboard.', '2026-03-22 20:30:00', 1),
(4,  5,  4,  'Can you confirm venue setup for Sunday?',        '2026-03-23 17:45:00', 0),
(5,  6,  5,  'Lineup change approved for the next series.',    '2026-03-24 20:20:00', 1),
(6,  7,  6,  'Please review the updated eligibility list.',     '2026-03-25 20:25:00', 0),
(7,  8,  7,  'Training camp registration closes tomorrow.',     '2026-03-26 22:20:00', 1),
(8,  9,  8,  'Sponsor meeting is scheduled for Friday noon.',   '2026-03-27 19:00:00', 0),
(9,  10, 9,  'Your performance metrics look excellent.',        '2026-03-28 17:40:00', 1),
(10, 1,  10, 'Thanks for organizing another smooth event.',     '2026-03-29 16:00:00', 0);

INSERT INTO notifications (
    user_id, type, reference_type, reference_id, message, is_read
) VALUES
(1,  'game_invite', 'game',    2,  'You have been invited to a soccer game.', 0),
(2,  'game_update', 'game',    1,  'Game 1 schedule changed by 15 minutes.',  1),
(3,  'new_game',    'game',    8,  'A new ultimate frisbee game is open.',     0),
(4,  'message',     'message', 3,  'You received a new scouting message.',      0),
(5,  'follow',      'user',    4,  'Avery Stone started following you.',        1),
(6,  'general',     'system',  1,  'Weekly leaderboard has been updated.',      0),
(7,  'game_invite', 'game',    9,  'You have been invited to a rugby session.', 0),
(8,  'message',     'message', 8,  'New contract message from your agent.',      1),
(9,  'game_update', 'game',    7,  'Field assignment updated for football game.',0),
(10, 'follow',      'user',    1,  'Jordan Blake started following you.',        0);

INSERT INTO followers (follower_id, following_id) VALUES
(1,  2),
(2,  3),
(3,  4),
(4,  5),
(5,  6),
(6,  7),
(7,  8),
(8,  9),
(9,  10),
(10, 1);

COMMIT;