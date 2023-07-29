package io.devpl.generator.service;

import io.devpl.generator.common.page.PageResult;
import io.devpl.generator.common.query.Query;
import io.devpl.generator.common.service.BaseService;
import io.devpl.generator.config.DataSourceInfo;
import io.devpl.generator.entity.GenDataSource;

import java.util.List;

/**
 * 数据源管理
 */
public interface DataSourceService extends BaseService<GenDataSource> {

    PageResult<GenDataSource> page(Query query);

    List<GenDataSource> getList();

    /**
     * 获取数据库产品名，如：MySQL
     * @param datasourceId 数据源ID
     * @return 返回产品名
     */
    String getDatabaseProductName(Long datasourceId);

    /**
     * 根据数据源ID，获取数据源
     * @param datasourceId 数据源ID
     */
    DataSourceInfo findById(Long datasourceId);
}
