CREATE OR REPLACE FUNCTION core.pf_ui_navigations(n_user_id integer, _c_view_type text) RETURNS TABLE(id integer, view_type text, alias text, leaf integer, icon_cls text, parent_id integer, name text, default_token integer, type text, icon text, expanded integer, selectable integer, not_auth integer, editable boolean, deletable boolean, creatable boolean, fullcontrol boolean, visible integer, sort integer)
    LANGUAGE plpgsql
    AS $$BEGIN
 RETURN QUERY 
 	select * from (select 
        MAX(nav.id) as id,
		MAX((CASE WHEN nav.b_leaf = false THEN '' ELSE nav.c_view_type END)) as view_type,
		MAX((CASE WHEN nav.b_leaf = false THEN '' ELSE nav.c_alias END)) as alias,
        MAX((CASE WHEN nav.b_leaf = false THEN 0 ELSE 1 END)) as leaf, 
        MAX(nav.c_icon_cls) as icon_cls, 
        MAX(nav.f_parent) as parent_id, 
        MAX(nav.c_name) as name, 
        MAX((CASE WHEN nav.b_default_token = false THEN 0 ELSE 1 END)) as default_token, 
        MAX(nav.c_type) as type, 
        MAX(nav.c_icon) as icon, 
        MAX((CASE WHEN nav.b_expanded = false THEN 0 ELSE 1 END)) as expanded,
        MAX((CASE WHEN nav.b_selectable = false THEN 0 ELSE 1 END)) as selectable,
        MAX((CASE WHEN nav.b_not_auth = false THEN 0 ELSE 1 END)) as not_auth,

        SUM(CASE WHEN a.b_editable = true THEN 1 ELSE 0 END) > 0 as editable, 
        SUM(CASE WHEN a.b_deletable = true THEN 1 ELSE 0 END) > 0 as deletable, 
        SUM(CASE WHEN a.b_creatable = true THEN 1 ELSE 0 END) > 0 as creatable, 
        SUM(CASE WHEN a.b_full_control = true THEN 1 ELSE 0 END) > 0 as fullcontrol,
        MAX((CASE WHEN nav.b_visible = false THEN 0 ELSE 1 END)) as visible,
		MAX(nav.n_sort) as sort
    from (
        select 
            n.id, 
            a.b_editable, 
            a.b_deletable, 
            a.b_creatable, 
            a.b_full_control, 
            core.sf_accesses(r.c_name, u.id, u.c_claims, a.f_user) as access 
        from core.pd_accesses as a
        inner join core.pd_navigations as n on a.c_name = n.c_alias
        left join core.sv_users as u on n_user_id = u.id
        left join core.pd_roles as r on a.f_role = r.id
        where n.c_type = _c_view_type and n.sn_delete = false and a.c_name is not null and a.c_criteria is null and a.sn_delete = false
    ) as a
    inner join core.pd_navigations as nav on a.id = nav.id
    where a.access > 0
    group by a.id) as t
    order by t.sort desc;
END; $$;

ALTER FUNCTION core.pf_ui_navigations(n_user_id integer, _c_view_type text) OWNER TO mobnius;

COMMENT ON FUNCTION core.pf_ui_navigations(n_user_id integer, _c_view_type text) IS 'Безопасность';
