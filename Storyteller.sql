CREATE TABLE IF NOT EXISTS vol_story_templates (
    template_id TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
    template_name VARCHAR(80) NOT NULL UNIQUE,
    PRIMARY KEY(template_id)
);

CREATE TABLE IF NOT EXISTS vol_story_personas (
	persona_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
	owner_id INT UNSIGNED NOT NULL,
	persona_name VARCHAR(80) NOT NULL,
	persona_parent INT UNSIGNED NULL,
	persona_date_created DATETIME NOT NULL,
	approval_id INT UNSIGNED NULL,
	PRIMARY KEY(persona_id),
	FOREIGN KEY(owner_id) REFERENCES vol_entity(entity_id) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(persona_parent) REFERENCES vol_story_personas(persona_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS vol_story_personas_approval (
    approval_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    persona_id INT UNSIGNED NOT NULL,
    admin_id INT UNSIGNED NOT NULL,
    approval_state TINYINT UNSIGNED NOT NULL,
    approval_date DATETIME NOT NULL,
    approval_notes TEXT NULL,
    PRIMARY KEY(approval_id),
    FOREIGN KEY(persona_id) REFERENCES vol_story_personas(persona_id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY(admin_id) REFERENCES vol_entity(entity_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS vol_story_trait_categories (
    trait_category_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    cat_name_1 VARCHAR(80) NOT NULL DEFAULT '',
    cat_name_2 VARCHAR(80) NOT NULL DEFAULT '',
    cat_name_3 VARCHAR(80) NOT NULL DEFAULT '',
    cat_name_4 VARCHAR(80) NOT NULL DEFAULT '',
    PRIMARY KEY(trait_category_id),
    UNIQUE(cat_name_1, cat_name_2, cat_name_3, cat_name_4)
);

CREATE TABLE IF NOT EXISTS vol_story_trait_categories_meta (
    trait_category_meta_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    trait_category_id INT UNSIGNED NOT NULL UNIQUE,
    persona_id INT UNSIGNED NOT NULL,
    date_created TIMESTAMP NOT NULL,
    PRIMARY KEY(trait_category_meta_id),
    FOREIGN KEY(trait_category_id) REFERENCES vol_story_trait_categories(trait_category_id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY(persona_id) REFERENCES vol_story_personas(persona_id) ON UPDATE CASCADE ON DELETE CASCADE,
);

CREATE TABLE IF NOT EXISTS vol_story_traits (
	trait_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    trait_category_id INT UNSIGNED NOT NULL,
	trait_name VARCHAR(80),
	PRIMARY KEY(trait_id),
	FOREIGN KEY(trait_category_id) REFERENCES vol_story_trait_categories(trait_category_id) ON UPDATE CASCADE ON DELETE CASCADE,
	UNIQUE(trait_category_id,trait_name)
);

CREATE TABLE IF NOT EXISTS vol_story_traits_meta (
    trait_meta_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    trait_id INT UNSIGNED NOT NULL UNIQUE,
    persona_id INT UNSIGNED NOT NULL,
    date_created TIMESTAMP NOT NULL,
    PRIMARY KEY(trait_meta_id),
    FOREIGN KEY(trait_id) REFERENCES vol_story_traits(trait_id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY(persona_id) REFERENCES vol_story_personas(persona_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS vol_story_persona_traits (
	persona_trait_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
	persona_id INT UNSIGNED NOT NULL,
	trait_id INT UNSIGNED NOT NULL,
	trait_value INT NOT NULL DEFAULT 0,
	trait_flags_1 TINYINT UNSIGNED NOT NULL DEFAULT 0,
	trait_flags_2 TINYINT UNSIGNED NOT NULL DEFAULT 0,
	PRIMARY KEY(persona_stat_id),
	FOREIGN KEY(persona_id) REFERENCES vol_story_personas(persona_id) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(trait_id) REFERENCES vol_story_traits(trait_id) ON UPDATE CASCADE ON DELETE CASCADE,
	UNIQUE(persona_id,trait_id)
);

CREATE TABLE IF NOT EXISTS vol_story_xp (
    xp_id TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
    xp_name VARCHAR(30) UNIQUE,
    xp_sort TINYINT UNSIGNED NOT NULL DEFAULT 0,
    PRIMARY KEY(xp_id)
);

CREATE TABLE IF NOT EXISTS vol_story_persona_xp (
    persona_xp_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    xp_id TINYINT UNSIGNED NOT NULL,
    persona_id INT UNSIGNED NOT NULL,
    xp_amount DECIMAL(7,3),
    admin_id INT UNSIGNED NOT NULL,
    xp_reason TEXT,
    xp_date DATETIME NOT NULL,
    xp_display_num INT UNSIGNED NOT NULL,
    PRIMARY KEY(persona_xp_id),
    FOREIGN KEY(persona_id) REFERENCES vol_story_personas(persona_id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY(xp_id) REFERENCES vol_story_xp(xp_id) ON UPDATE CASCADE ON DELETE CASCADE,
    UNIQUE(xp_id,persona_id,xp_display_num)
);

CREATE OR REPLACE VIEW volv_story_persona_xp AS
    SELECT px.*,UNIX_TIMESTAMP(px.xp_date) AS xp_date_secs,p.persona_name,p.owner_name,p.owner_objid,x.xp_name,x.xp_sort,e.entity_name AS admin_name,e.entity_objid AS admin_objid FROM vol_story_persona_xp AS px LEFT JOIN vol_story_xp AS x ON px.xp_id=x.xp_id LEFT JOIN volv_story_personas AS p ON px.persona_id=p.persona_id LEFT JOIN vol_entity AS e ON px.admin_id=e.entity_id ORDER BY x.xp_sort;

CREATE OR REPLACE VIEW volv_story_persona_xp_totals AS
    SELECT x.xp_id,x.xp_name,x.xp_sort,x.persona_id,x.persona_name,x.owner_name,x.owner_objid,MAX(IF(x.xp_display_num,x.xp_display_num,1))+1 AS next_display_num,SUM(IF(x.xp_amount>0,x.xp_amount,0)) AS xp_gained,ABS(SUM(IF(x.xp_amount<0,x.xp_amount,0))) AS xp_spent,SUM(x.xp_amount) AS xp_current
    FROM volv_story_persona_xp AS x
    GROUP BY x.xp_id,x.persona_id ORDER BY x.persona_name,x.xp_sort;

DROP PROCEDURE IF EXISTS volp_story_xp;
DELIMITER $$
CREATE PROCEDURE volp_story_xp(IN in_persona_id INT UNSIGNED,IN in_xp_id TINYINT UNSIGNED,IN in_xp_amount DECIMAL(7,3),IN in_xp_reason TEXT,IN in_admin_id INT UNSIGNED)
BEGIN
    DECLARE next_num INT UNSIGNED;
    DECLARE new_persona_xp_id INT UNSIGNED;
    SELECT next_display_num INTO next_num FROM volv_story_persona_xp_totals WHERE persona_id=in_persona_id AND xp_id=in_xp_id;
    IF next_num IS NULL THEN
      SET next_num=1;
    END IF;
    INSERT INTO vol_story_persona_xp(persona_id,xp_id,xp_display_num,xp_amount,admin_id,xp_reason,xp_date) VALUES (in_persona_id,in_xp_id,next_num,in_xp_amount,in_admin_id,in_xp_reason,UTC_TIMESTAMP());
    SET new_persona_xp_id=LAST_INSERT_ID();
    SELECT new_persona_xp_id;
END $$
DELIMITER ;