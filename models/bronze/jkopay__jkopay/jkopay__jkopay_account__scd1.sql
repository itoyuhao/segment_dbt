{{
    generate_bronze(
        source_name="jkopay__mssql_jkopay",
        source_table="account",
        unique_key="id",
        time_field="update_time",
    )
}}
