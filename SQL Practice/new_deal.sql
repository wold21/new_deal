-- 공지사항 화면

-- 1 공지사항을 누르면
-- select notice_id, notice_tit, loginId, date_format(regdate, '%Y.%m.%d'), hit
-- 	from tb_adm_notice
--     order by notice_id desc;
    
-- select notice_id, notice_tit, loginId, date_format(regdate, '%Y.%m.%d'), hit
-- 	from tb_tutor_notice
--     order by notice_id desc;



-- 2 글을 누르면,
-- select notice_id, notice_tit, loginId, date_format(regdate, '%Y.%m.%d'), hit
-- 	from tb_adm_notice
--     where notice_id = 30
-- 	order by notice_id desc



-- 3 수정 화면
-- select notice_id, loginId, date_format(regdate, '%Y.%m.%d'), hit
-- 	from tb_adm_notice
--     where notice_id = 30



-- 학습관리
-- 수강상담이력

-- 1 수강 상담 이력을 누르면
-- select lec_id, lec_name, concat(date_format(c_st, '%Y.%m.%d'), '~', date_format(c_end, '%Y.%m.%d'))
-- 	from tb_lec_info;

-- 2 상담관리 과정명을 누르면
-- select ta.adv_id, tli.lec_name, concat(tui.name,' (', ta.std_id, ')'), ta.adv_date, concat(tli.tutor_id, ' (', tli.tutor_name, ')') 
-- from tb_adv ta left join tb_lec_info tli
--     on ta.lec_id = tli.lec_id
--     left join tb_userinfo tui
--     on ta.std_id = tui.loginID
--     order by ta.adv_id desc

-- select *
-- 	from tb_lec_info


-- 진도 관리
-- select lec_name, tutor_name, date_format(c_st, '%Y.%m.%d'), date_format(c_end, '%Y.%m.%d'), lecrm_id, pre_pnum, max_pnum
-- 	from tb_lec_info

-- select twp.week, twp.learn_con ,twp.learn_goal
-- 	from tb_week_plan twp inner join tb_lec_info tli
--     on twp.lec_id = tli.lec_id
-- 	order by twp.week

-- select concat(process_day, '일') '총 수업 수', concat(pre_day, '일') '현 수업 수', concat(truncate(pre_day / process_day * 100, 0), '%') 진행률
-- 	from tb_lec_info;

-- 강의 관리
-- select tli.lec_id '강의 번호', tli.lec_name 강의명, tui.name 담당교수, tli.lecrm_id 강의실, tli.pre_pnum 수강인원, concat(date_format(tli.c_st, '%Y.%m.%d'),'-', date_format(tli.c_end, '%Y.%m.%d')) 기간
-- 	from tb_lec_info tli left join tb_userinfo tui
--     on tli.tutor_id = tui.loginID
--     order by lec_id desc;


-- 설문조사관리
-- select  loginID '강사ID' ,name 강사명, tel '강사 전화번호', mail '강사 이메일', join_date 강의가입일
-- 	from tb_userinfo tui
--     where user_type = 'B'
--     order by mail

-- 보류
-- select tli.lec_name, tt.test_name, concat(date_format(tt.test_start, '%Y.%m.%d'), '-', tt.test_end) 시험기간, (case when tt.test_end < now() then '시험 완료' else '시험 중' end) 상태 
-- 	from tb_test tt left join tb_lec_info tli
--     on tt.lec_id = tli.lec_id
--     left join tb_test_user ttu
--     on tt.test_id = ttu.test_id;
    
    
-- 강사 목록
-- select name 강사명, tel '강사 연락처', mail 이메일
-- 	from tb_userinfo
--     where user_type = 'B'


-- 취업관리
-- 이력서 관리
-- select tli.lec_id '강의 번호', tli.lec_name 강의명, tli.tutor_name 담당교수, tli.pre_pnum 수강인원, concat(date_format(tli.c_st, '%Y.%m.%d'),' ~ ', date_format(tli.c_end, '%Y.%m.%d')) '개강일/종강일'
-- 	from tb_lec_info tli left join tb_userinfo tui
--     on tli.tutor_id = tui.loginID
--     order by lec_id


-- 취업 정보
-- select tui.std_num, tui.name, tui.tel, tli.lec_name, tui.join_date
-- 	from tb_userinfo tui left join tb_lec_info tli
--     on tui.loginID = tli.tutor_id
--     where tui.user_type = 'A'
--     order by tui.name
    




