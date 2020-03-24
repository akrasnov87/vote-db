CREATE OR REPLACE FUNCTION core.pf_ui_actions(n_user_id integer) RETURNS TABLE("viewId" text, text text, icon text, "directFn" text, "actionViewId" text, xtype text, place text, sort integer, tooltip text, ui text, access integer, "parentId" integer, "recordId" integer, "selectionDependencyType" text, "confirmationMessage" text, "javascriptFn" text)
    LANGUAGE plpgsql
    AS $$BEGIN
 RETURN QUERY 
 	select * from (select 
	MAX(a.c_view_id) as view_id, 
	MAX(a.c_text) as "text", 
	MAX(a.c_icon) as "icon", 
	MAX(a.c_operation) as "operation", 
	MAX(a.c_action_view) as action_view, 
	MAX(a.c_xtype) as "xtype", 
	MAX(a.c_place) as "place", 
	MAX(a.n_sort) as "sort", 
	MAX(a.c_tooltip) as "tooltip", 
	MAX(a.c_ui) as "ui",
    MAX(a.access) as "access",
    MAX(a.f_parent) as "parent_id",
    MAX(a.id) as "item_id",
	MAX(a."c_selectiondependencytype") as "selectionDependencyType",
    MAX(a."c_confirmationmessage") as "confirmationMessage",
    MAX(a.c_javascript_fn) as "javascript_fn"		
    from (
        select 
            sa.id,
            sa.c_view_id, 
            sa.c_text, 
            sa.c_icon, 
            sa.c_operation, 
            sa.c_action_view, 
            sa.c_xtype, 
            sa.c_place, 
            sa.n_sort, 
            sa.c_tooltip,
            sa.c_ui,
            sa.f_parent,
			sa."c_selectiondependencytype",
            sa."c_confirmationmessage",
            sa.c_javascript_fn,
            core.sf_accesses(r.c_name, u.id, u.c_claims, aa.f_user) as access
        from core.pd_accesses as aa
        inner join core.sd_ui_actions as sa on aa.f_action = sa.id
        left join core.sv_users as u on n_user_id = u.id
        left join core.pd_roles as r on aa.f_role = r.id
        where aa.f_action is not null and aa.sn_delete = false and sa.sn_delete = false
    ) as a
    inner join core.sd_ui_actions as sa on a.id = sa.id
    where a.access > 0
    group by sa.id) as t
    order by t.place, t.sort;
END; $$;

ALTER FUNCTION core.pf_ui_actions(n_user_id integer) OWNER TO mobnius;

COMMENT ON FUNCTION core.pf_ui_actions(n_user_id integer) IS 'возвращается список кнопок, которые могут выводиться для viewId';
