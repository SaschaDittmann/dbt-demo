from __future__ import print_function
from datetime import datetime, timedelta

from airflow.models import Variable
from airflow import DAG
from airflow.operators.bash_operator import BashOperator
from airflow.operators.python_operator import PythonOperator

default_dag_args = {
    'owner': 'airflow',
    'start_date': datetime(2022, 8, 27, 23, 0, 0),
}

with DAG(
        'wide_world_importers',
        schedule_interval=timedelta(days=1),
        default_args=default_dag_args) as dag:

    checkout = BashOperator(
        # The ID specified for the task.
        task_id='checkout',
        bash_command='git clone {{ var.value.git_remote_url }}'
        )

    install_dbt = BashOperator(
        # The ID specified for the task.
        task_id='install-dbt',
        bash_command='python3 -m pip install --upgrade --no-cache dbt-core dbt-bigquery'
        )

    resolve_dependencies = BashOperator(
        # The ID specified for the task.
        task_id='resolve-dependencies',
        bash_command='echo'
        )
    
    check_source_freshness = BashOperator(
        # The ID specified for the task.
        task_id='check-source-freshness',
        bash_command='echo'
        )

    run_source_tests = BashOperator(
        # The ID specified for the task.
        task_id='run-source-tests',
        bash_command='echo'
        )

    add_seeds = BashOperator(
        # The ID specified for the task.
        task_id='add-seeds',
        bash_command='echo'
        )

    run_transformations = BashOperator(
        # The ID specified for the task.
        task_id='run-transformations',
        bash_command='echo'
        )

    generate_docs = BashOperator(
        # The ID specified for the task.
        task_id='generate-docs',
        bash_command='echo'
        )

    run_tests = BashOperator(
        # The ID specified for the task.
        task_id='run-tests',
        bash_command='echo'
        )

    checkout >> resolve_dependencies
    install_dbt >> resolve_dependencies
    resolve_dependencies >> check_source_freshness
    check_source_freshness >> run_source_tests
    run_source_tests >> add_seeds
    add_seeds >> run_transformations
    run_transformations >> run_tests
    run_tests >> generate_docs
