<%@ page language="java" pageEncoding="UTF-8"%>
<div class="mainLeft">
    <ul class="list">
        <shiro:hasRole name="admin">

        <li>
            <a href="javascript:;" class="managementList" id="e1">授权管理<span></span></a>
            <ul class="child_menu" id="m1">
                <li><a href="enterprise-list.html">企业列表</a></li>
            </ul>
        </li>
        <li>
            <a href="eartag-manage.html" class="managementList" id="e2">耳标管理</a>
        </li>
        <li>
            <a href="pda-manage.html" class="managementList" id="e3">PDA管理</a>
        </li>
        <li>
            <a href="javascript:;" class="managementList" id="e4">基础数据管理<span></span></a>
            <ul class="child_menu" id="m4">
                <li><a href="drug-manage.html">药品数据管理</a></li>
                <li><a href="feed-manage.html">饲料数据管理</a></li>
                <li><a href="diagnosis-manage.html">诊疗结果管理</a></li>
                <li><a href="diagnosis-plan.html">诊疗方案管理</a></li>
                <li><a href="livestock-manage.html">活畜品种信息管理</a></li>
                <li><a href="tag-manage.html">追溯标签信息管理</a></li>
                <li><a href="vehicle-manage.html">车辆信息管理</a></li>
                <li><a href="security-code.html">防伪码信息管理</a></li>
            </ul>
        </li>
        </shiro:hasRole>
        <li>
            <a href="javascript:;" class="managementList" id="e5">养殖管理<span></span></a>
            <ul class="child_menu" id="m5">
                <li><a href="farm-manage.html">养殖管理</a></li>
                <li><a href="weight-list.html">称重记录</a></li>
                <li><a href="feeding-list.html">喂养记录</a></li>
                <li><a href="disposal-list.html">无害化处理</a></li>
                <li><a href="offlinesales-list.html">线下销售</a></li>
                <li><a href="environmentmonitoring-list.html">养殖环境监测</a></li>
                <li><a href="immune-list.html">免疫记录</a></li>
                <li><a href="diagnosis-list.html">诊疗记录</a></li>
                <li><a href="quarantine-list.html">检疫管理</a></li>

            </ul>
        </li>
        <li>
            <a href="enterprise-disinfection.html" class="managementList" id="e6">企业消毒记录</a>
        </li>
        <li>
            <a href="javascript:;" class="managementList" id="e7">屠宰管理<span></span></a>
            <ul class="child_menu" id="m7">
                <li><a href="slaughter-record.html">屠宰记录</a></li>
            </ul>
        </li>
        <li>
            <a href="javascript:;" class="managementList" id="e8">加工管理<span></span></a>
            <ul class="child_menu" id="m8">
                <li><a href="package-manage.html">包装管理</a></li>
                <li><a href="paisuan-record.html">排酸记录</a></li>
                <li><a href="splitprint-record.html">分割打印记录</a></li>
                <li><a href="logistics-record.html">物流记录</a></li>
            </ul>
        </li>
        <li>
            <a href="javascript:;" class="managementList" id="e9">商户操作管理<span></span></a>
            <ul class="child_menu" id="m9">
                <li><a href="harvest-record.html">收货记录</a></li>
                <li><a href="restaurantsplit-record.html">餐厅分割记录</a></li>
            </ul>
        </li>
        <li>
            <a href="storage-manage.html" class="managementList" id="e10">库存管理</a>
        </li>
        <shiro:hasRole name="admin">
        <li>
            <a href="https://auth.ys7.com/signIn?from=4e4148ba90184a7cbd81&r=561590235011157722&returnUrl=plugin&host=i.ys7.com" class="managementList">视频监控</a>
        </li>
        </shiro:hasRole>
    </ul>
</div>
