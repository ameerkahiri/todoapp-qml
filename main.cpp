#include <QGuiApplication>
#include <QQmlApplicationEngine>

// to expose c++ object to QML
#include <QQmlContext>
#include "addtask.h"
#include "addtaskmodel.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;


    // register model with QML type
    qmlRegisterType<addTaskModel>("AddTask", 1, 0, "MainAddTaskModel");

    AddTask mainAddTask;
    // expose object to QML : (nameInQML, varInC++)
    engine.rootContext()->setContextProperty(QStringLiteral("mainAddTask"), &mainAddTask);



    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
