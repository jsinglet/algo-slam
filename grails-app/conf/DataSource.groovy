dataSource {
    pooled = true
    driverClassName = "com.mysql.jdbc.Driver"
    username = "root"
    password = "fruitile"

    properties {
        maxActive = 20
        maxIdle = 10
        minIdle = 5
        initialSize = 5
        minEvictableIdleTimeMillis = 60000
        timeBetweenEvictionRunsMillis = 60000
        maxWait = 10000
        validationQuery = "SELECT 1"
    }
}
hibernate {
    cache.use_second_level_cache = true
    cache.use_query_cache = true
    cache.provider_class = 'net.sf.ehcache.hibernate.EhCacheProvider'
}
// environment specific settings
environments {
    development {
        dataSource {
            dbCreate = "update" // one of 'create', 'create-drop','update'
            url = "jdbc:mysql://localhost/slam"
            username = "root"
            password = "testpw"
        }
        hibernate {
            show_sql = true
        }
    }
    test {
        dataSource {
            dbCreate = "create-drop" // one of 'create', 'create-drop','update'
            url = "jdbc:mysql://localhost/TESTDBNAME?useUnicode=yes&characterEncoding=UTF-8"
            username = "test"
            password = "testpw"
        }
    }
    production {
        dataSource {
            dbCreate = "update"
            url = "jdbc:mysql://slam.cyflerzrqee9.us-east-1.rds.amazonaws.com/slam"
            username = "root"
            password = "testpw"
        }
    }
}