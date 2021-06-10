print('Init Start #################################################################');

db.auth("root", "root123456");

db = db.getSiblingDB('yapi');

db.createUser({
    user: 'yapi',
    pwd: 'yapi123456',
    roles: [
        {
            role: "dbAdmin",
            db: "yapi"
        },
        {
            role: "readWrite",
            db: "yapi"
        }
    ]
});

print('Init END ###################################################################');