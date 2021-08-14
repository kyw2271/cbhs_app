# Generated by Django 3.1.6 on 2021-08-14 05:07

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Cbhs1_Menu',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('Days', models.DateField()),
                ('B', models.CharField(max_length=255)),
                ('L', models.CharField(max_length=255)),
                ('D', models.CharField(max_length=255)),
                ('B_num', models.IntegerField()),
                ('L_num', models.IntegerField()),
                ('D_num', models.IntegerField()),
            ],
        ),
        migrations.CreateModel(
            name='Cbhs2_Menu',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('Days', models.DateField()),
                ('B', models.CharField(max_length=255)),
                ('L', models.CharField(max_length=255)),
                ('D', models.CharField(max_length=255)),
                ('B_num', models.IntegerField()),
                ('L_num', models.IntegerField()),
                ('D_num', models.IntegerField()),
            ],
        ),
        migrations.CreateModel(
            name='Cbhs3_Menu',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('Days', models.DateField()),
                ('B', models.CharField(max_length=255)),
                ('L', models.CharField(max_length=255)),
                ('D', models.CharField(max_length=255)),
                ('B_num', models.IntegerField()),
                ('L_num', models.IntegerField()),
                ('D_num', models.IntegerField()),
            ],
        ),
    ]
