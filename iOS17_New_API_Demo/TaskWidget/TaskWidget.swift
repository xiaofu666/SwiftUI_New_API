//
//  TaskWidget.swift
//  TaskWidget
//
//  Created by Lurich on 2023/6/12.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> TaskEntry {
        TaskEntry(lastThreeTasks: Array(TaskDataModel.shared.tasks.prefix(3)))
    }

    func getSnapshot(in context: Context, completion: @escaping (TaskEntry) -> ()) {
        let entry = TaskEntry(lastThreeTasks: Array(TaskDataModel.shared.tasks.prefix(3)))
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let lastThreeTasks = Array(TaskDataModel.shared.tasks.prefix(3))
        let lastEntries = [TaskEntry(lastThreeTasks: lastThreeTasks)]
        let timeline = Timeline(entries: lastEntries, policy: .atEnd)
        completion(timeline)
    }
}

struct TaskEntry: TimelineEntry {
    let date: Date = .now
    var lastThreeTasks: [TaskModel]
}

struct TaskWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Task's")
                .fontWeight(.semibold)
                .padding(.bottom, 10)
            
            VStack(alignment: .leading, spacing: 6, content: {
                if entry.lastThreeTasks.isEmpty {
                    Text("No Task's Found")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    ForEach(entry.lastThreeTasks.sorted(by: {
                        !$0.isCompleted && $1.isCompleted
                    })) { taskModel in
                        HStack(spacing: 6) {
                            Button(intent: ToggleStateIntent(id: taskModel.id)) {
                                Image(systemName: taskModel.isCompleted ? "checkmark.circle.fill" : "circle")
                                    .foregroundColor(.blue)
                            }
                            .buttonStyle(.plain)
                            
                            VStack(alignment: .leading, spacing: 4, content: {
                                Text(taskModel.title)
                                    .foregroundStyle(taskModel.isCompleted ? .secondary : .primary)
                                    .textScale(.secondary)
                                    .lineLimit(1)
                                    .strikethrough(taskModel.isCompleted, pattern: .solid, color: .secondary)
                                
                                Divider()
                            })
                        }
                        
//                        if taskModel.id != entry.lastThreeTasks.id {
//                            Spacer(minLength: 0)
//                        }
                    }
                }
            })
        }
        .containerBackground(.fill.tertiary, for: .widget)
    }
}

struct TaskWidget: Widget {
    let kind: String = "TaskWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            TaskWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Task Widget")
        .description("This is an example of interactive widget.")
    }
}

#Preview(as: .systemSmall) {
    TaskWidget()
} timeline: {
    TaskEntry(lastThreeTasks: Array(TaskDataModel.shared.tasks.prefix(3)))
}
