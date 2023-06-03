const Sequelize = require('sequelize');
const sequelize = new Sequelize(
  'ble2xtmr8gvrxnrxo3ic',
  'uljyctctqboxq1jl',
  'QGb3q5Nx9NvDDXeIYIO2',
  {
    host: 'ble2xtmr8gvrxnrxo3ic-mysql.services.clever-cloud.com',
    dialect: 'mysql'
  }
);


const { DataTypes } = require('sequelize');

const Dog = sequelize.define('Dog', {
    name: {
      type: DataTypes.STRING,
      allowNull: false
    },
    age: {
      type: DataTypes.INTEGER,
      allowNull: false
    },
    photo: {
      type: DataTypes.BLOB,
      allowNull: true
    },
    description: {
      type: DataTypes.TEXT,
      allowNull: true
    },
    vaccinated: {
      type: DataTypes.BOOLEAN,
      allowNull: true
    },
    spayed: {
      type: DataTypes.BOOLEAN,
      allowNull: true
    },
    has_chip: {
      type: DataTypes.BOOLEAN,
      allowNull: true
    },
    friendly_with_people: {
      type: DataTypes.BOOLEAN,
      allowNull: true
    },
    friendly_with_pets: {
      type: DataTypes.BOOLEAN,
      allowNull: true
    },
    health_state: {
      type: DataTypes.STRING,
      allowNull: true
    },
    description: {
      type: DataTypes.TEXT,
      allowNull: true
    }
  });

  module.exports = Dog;