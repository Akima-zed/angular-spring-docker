import { CommonModule } from '@angular/common';
import { Component, input, InputSignal, Signal } from '@angular/core';
import { Olympic } from 'src/app/core/models/Olympic';

@Component({
  selector: 'app-home',
  imports: [CommonModule],
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.scss'],
})
export class HomeComponent {
  public readonly olympics: InputSignal<Array<Olympic>> =
    input.required<Array<Olympic>>();

  constructor() {}
}
